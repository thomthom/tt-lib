# frozen_string_literal: true
# tt-lib³ is a a `skippy` library for SketchUp.
#
# Pick and choose what modules and classes you need for your SketchUp extension
# project.
#
# You can use `skippy` to automate the management of your library dependency or
# you can manually copy+paste what you need.
#
# @sketchup 2014
module SkippyLib

  # @private
  # @since 3.0.0
  def self.reload
    original_verbose = $VERBOSE
    $VERBOSE = nil
    load __FILE__ # rubocop:disable SketchupSuggestions/FileEncoding
    pattern = "#{__dir__}/**/*.rb"
    Dir.glob(pattern) { |file|
      load file
    }
  ensure
    $VERBOSE = original_verbose
  end

end
