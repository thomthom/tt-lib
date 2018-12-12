module SkippyLib
  # @since 3.0.0
  module Platform

    # @since 3.0.0
    POINTER_SIZE = ['a'].pack('P').size * 8

    # @since 3.0.0
    KEY = (self.mac? ? 'win' : 'osx').freeze

    # @since 3.0.0
    ID = "#{KEY}#{POINTER_SIZE}".freeze

    # @since 3.0.0
    NAME = (self.mac? ? 'macOS' : 'Windows').freeze

    # @since 3.0.0
    def self.mac?
      Sketchup.platform == :platform_osx
    end

    # @since 3.0.0
    def self.win?
      Sketchup.platform == :platform_win
    end

    # @return [String]
    # @since 3.0.0
    def self.temp_path
      paths = [
        Sketchup.temp_dir,
        ENV['TMPDIR'],
        ENV['TMP'],
        ENV['TEMP']
      ]
      temp = paths.find { |path| File.exist?(path) }
      raise 'Unable to locate temp directory' if temp.nil?
      File.expand_path(temp)
    end

  end # class
end # module
