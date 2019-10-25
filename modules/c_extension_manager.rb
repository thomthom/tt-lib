# frozen_string_literal: true
require 'fileutils'

Sketchup.require 'modules/object_utils'
Sketchup.require 'modules/platform'

module SkippyLib
  # Loads the appropriate C Extension loader after ensuring the appropriate
  # version has been copied from the staging area.
  #
  # @since 3.0.0
  class CExtensionManager

    include ObjectUtils

    class IncompatibleVersion < RuntimeError; end

    # Acceptable versions:
    # * Major.Minor.Revision
    # * Major.Minor.Revision.Build
    # @private
    VERSION_PATTERN = /\d+\.\d+\.\d+(?:.\d+)?$/.freeze

    # The `library_path` argument should point to the path where a 'stage'
    # folder is located with the following folder structure:
    #
    #     + <library_path>
    #     +-+ stage
    #       +-+ 1.8
    #       | +-+ HelloWorld.so
    #       |   + HelloWorld.bundle
    #       +-+ 2.0
    #         +-+ HelloWorld.so
    #           + HelloWorld.bundle
    #
    # The appropriate file will be copied on demand to a folder structure like:
    # `<library_path>/<EXTENSION_VERSION>/<RUBY_VERSION>/HelloWorld.so`
    #
    # When a new version is deployed the files will be copied again from the
    # staging area to a new folder named with the new extension version.
    #
    # The old versions are cleaned up if possible. This attempt is done upon
    # each time {#prepare_path} is called.
    #
    # This way the C extensions can be updated because they are never loaded
    # from the staging folder directly.
    #
    # @param [SketchupExtension] extension The extension version.
    # @param [String] library_path The location where the C Extensions are
    #                              located.
    # @since 3.0.0
    def initialize(extension, library_path)
      # ENV, __FILE__, $LOAD_PATH, $LOADED_FEATURE and more might return an
      # encoding different from UTF-8 under Windows. It's often ASCII-US or
      # ASCII-8BIT. If the developer has derived from these strings the encoding
      # sticks with it and will often lead to errors further down the road when
      # trying to load the files. To work around this the path is attempted to
      # be relabeled as UTF-8 if we can produce a valid UTF-8 string.
      # I'm forcing an encoding instead of converting because the encoding label
      # of the strings seem to be consistently mislabeled - the data is in
      # fact UTF-8.
      if library_path.respond_to?(:encoding)
        test_path = library_path.dup.force_encoding('UTF-8')
        library_path = test_path if test_path.valid_encoding?
      end

      unless version =~ VERSION_PATTERN
        raise ArgumentError, 'Version must be in "X.Y.Z" format'
      end
      unless File.directory?(library_path)
        raise IOError, "Stage path not found: #{library_path}"
      end

      @extension = extension
      @path = library_path
      @stage = File.join(library_path, 'stage')
      @target = File.join(library_path, extension.version)
    end

    # Copies the necessary C Extension libraries to a version dependent folder
    # from where they can be loaded. This will allow the SketchUp RBZ installer
    # to update the extension without running into errors when trying to
    # overwrite files from previous installation.
    #
    # @return [String] The path where the extensions are located.
    # @since 3.0.0
    def prepare_path
      ruby_version = RUBY_VERSION.match(/(\d+\.\d+)\.\d/)[1]
      stage_path = File.join(@stage, ruby_version, Platform::ID)
      target_path = File.join(@target, ruby_version, Platform::ID)
      fallback = false

      begin
        # Copy files if target doesn't exist.
        unless File.directory?(stage_path)
          raise IncompatibleVersion, "Staging directory not found: #{stage_path}"
        end

        unless File.directory?(target_path)
          FileUtils.mkdir_p(target_path)
        end
        stage_content = Dir.entries(stage_path)
        target_content = Dir.entries(target_path)
        unless (stage_content - target_content).empty?
          FileUtils.copy_entry(stage_path, target_path)
        end

        # Clean up old versions.
        filter = File.join(@path, '*')
        Dir.glob(filter).each { |entry|
          next unless File.directory?(entry)
          next if [@stage, @target].include?(entry)
          next unless entry =~ VERSION_PATTERN

          begin
            FileUtils.rm_r(entry)
          rescue
            puts "#{@extension.name} - Unable to clean up: #{entry}"
          end
        }
      rescue Errno::EACCES
        if fallback
          UI.messagebox(
            "Failed to load #{@extension.name}. Missing permissions to " \
            'Plugins and temp folder.'
          )
          raise
        else
          # Even though the temp folder contains the username, it appear to be
          # returned in DOS 8.3 format which Ruby 1.8 can open. Fall back to
          # using the temp folder for these kind of systems.
          puts "#{@extension.name} - Unable to access: #{target_path}"
          short_name = @extension.name.gsub(/[^A-Za-z0-9_-]/, '')
          temp_lib_path = File.join(Platform.temp_path, short_name)
          target_path = File.join(temp_lib_path,
              @extension.version,
              ruby_version,
              Platform::ID)
          puts "#{@extension.name} - Falling back to: #{target_path}"
          fallback = true
          retry
        end
      end

      target_path
    end

    # @return [String]
    # @since 3.0.0
    def inspect
      inspect_object
    end
    alias to_s inspect

  end # class

end # module
