# frozen_string_literal: true

Sketchup.require 'modules/resource'

module SkippyLib
  # A wrapper on top of `UI::Command` which will automatically pick the
  # appropriate vector fileformat alternative for icon resources.
  #
  # @since 3.0.0
  module Command

    # Allows for an error handler to be configured for when commands raises an
    # error. Useful for providing general feedback to the user or error loggers.
    #
    # @since 3.0.0
    def self.set_error_handler(&block)
      @error_handler = block
    end

    # @param [String] title
    # @since 3.0.0
    def self.new(title, &block)
      # SketchUp allocate the object by implementing `new` - probably part of
      # older legacy implementation when that was the norm. Because of that the
      # class cannot be sub-classed directly. This module simulates the
      # interface for how UI::Command is created. `new` will create an instance
      # of UI::Command but mix itself into the instance - effectively
      # subclassing it. (yuck!)
      command = UI::Command.new(title) {
        begin
          block.call
        rescue Exception => e # rubocop:disable Lint/RescueException
          if @error_handler.nil?
            raise
          else
            @error_handler.call(e)
          end
        end
      }
      command.extend(self)
      command.instance_variable_set(:@proc, block)
      command
    end

    # @return [Proc]
    # @since 3.0.0
    def proc
      @proc
    end

    # @since 3.0.0
    def invoke
      @proc.call
    end

    # Sets the large icon for the command. Provide the full path to the raster
    # image and the method will look for a vector variant in the same folder
    # with the same basename.
    #
    # @param [String] path
    # @since 3.0.0
    def large_icon=(path)
      super(Resource.icon_path(path))
    end

    # @see #large_icon
    #
    # @param [String] path
    # @since 3.0.0
    def small_icon=(path)
      super(Resource.icon_path(path))
    end

  end # module
end # module
