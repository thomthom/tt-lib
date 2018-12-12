require 'modules/color'

module SkippyLib
  # @since 3.0.0
  class Color < Sketchup::Color

    # @since 3.0.0
    def greyscale?
      red == green && green == blue
    end

    # @return [Integer] Value between 0 - 255
    # @since 3.0.0
    def luminance
      # Colorimetric conversion to greyscale.
      # Original:
      # http://forums.sketchucation.com/viewtopic.php?t=12368#p88865
      # (red * 0.3) + (green * 0.59) + (blue * 0.11)
      # Current: https://stackoverflow.com/a/596243/486990
      #  => https://www.w3.org/TR/AERT/#color-contrast
      ((red * 299) + (green * 587) + (blue * 114)) / 1000
    end

  end
end # module
