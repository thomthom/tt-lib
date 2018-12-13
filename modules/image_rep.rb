Sketchup.require 'modules/platform'

module SkippyLib
  # @sketchup 2018
  # @since 3.0.0
  module ImageRepHelper

    extend self

    # @param [Integer] width
    # @param [Integer] height
    # @param [Array<Sketchup::Color>] colors
    # @return [Sketchup::ImageRep]
    # @since 3.0.0
    def self.colors_to_image_rep(width, height, colors)
      row_padding = 0
      bits_per_pixel = 32
      pixel_data = self.colors_to_32bit_bytes(colors)
      # rubocop:disable SketchupSuggestions/Compatibility
      image_rep = Sketchup::ImageRep.new
      # rubocop:enable SketchupSuggestions/Compatibility
      image_rep.set_data(width, height, bits_per_pixel, row_padding, pixel_data)
      image_rep
    end

    # From C API documentation on SUColorOrder
    #
    # > SketchUpAPI expects the channels to be in different orders on
    # > Windows vs. Mac OS. Bitmap data is exposed in BGRA and RGBA byte
    # > orders on Windows and Mac OS, respectively.
    #
    # @param [Array<Sketchup::Color>] color
    # @return [Array(Integer, Integer, Integer, Integer)] RGBA/BGRA
    # @since 3.0.0
    def self.color_to_32bit(color)
      r, g, b, a = color.to_a
      Platform::IS_WIN ? [b, g, r, a] : [r, g, b, a]
    end

    # @param [Array<Sketchup::Color>] colors
    # @return [String] Binary byte string of raw image data.
    # @since 3.0.0
    def self.colors_to_32bit_bytes(colors)
      colors.map { |color| self.color_to_32bit(color) }.flatten.pack('C*')
    end

    # @param [Array<Sketchup::Color>] color
    # @return [Array(Integer, Integer, Integer)] RGBA/BGRA
    # @since 3.0.0
    def self.color_to_24bit(color)
      self.color_to_32bit(color)[0, 3]
    end

    # @param [Array<Sketchup::Color>] colors
    # @return [String] Binary byte string of raw image data.
    # @since 3.0.0
    def self.colors_to_24bit_bytes(colors)
      colors.map { |color| self.color_to_24bit(color) }.flatten.pack('C*')
    end

  end
end # module
