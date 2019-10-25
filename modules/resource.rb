# frozen_string_literal: true

Sketchup.require 'modules/platform'

module SkippyLib
  # @since 3.0.0
  module Resource

    # The supported file format for vector icons depend on the platform.
    # @since 3.0.0
    VECTOR_FILETYPE = (Platform.mac? ? 'pdf' : 'svg').freeze

    # Provide the path to a bitmap icon, which will be used for older SketchUp
    # versions that doesn't support vector formats.
    #
    # For versions that do support vector formats it will return the path with
    # the file extension that is compatible with the running OS.
    #
    # If the vector variant doesn't exist the original path will be returned.
    #
    # @param [String] path
    # @return [String]
    # @since 3.0.0
    def self.icon_path(path)
      return path unless Sketchup.version.to_i > 15

      vector_icon = self.vector_path(path)
      File.exist?(vector_icon) ? vector_icon : path
    end

    # @param [String] path
    # @return [String]
    # @since 3.0.0
    def self.vector_path(path)
      dir = File.dirname(path)
      basename = File.basename(path, '.*')
      File.join(dir, "#{basename}.#{VECTOR_FILETYPE}")
    end

  end # module
end # module
