# frozen_string_literal: true

module SkippyLib

  # Alias to make code more readable.
  #
  # The SketchUp Ruby API deal with `Geom::Point3d` objects when it comes to
  # UV mapping. But this can make it hard to read the intent of the code when
  # everything is a `Geom::Point3d`.
  #
  # @since 3.0.0
  class UV < Geom::Point3d

    # @param [UVQ, Geom::Point3d] uvq
    # @since 3.0.0
    def self.from_uvq(uvq)
      self.new(uvq.x / uvq.z, uvq.y / uvq.z)
    end

    # @param [Float] x
    # @param [Float] y
    # @since 3.0.0
    def initialize(x, y)
      super(x, y, 1.0)
    end

    # @since 3.0.0
    alias u x

    # @since 3.0.0
    alias v y

    # @since 3.0.0
    alias q z

    # @return [UVQ]
    # @since 3.0.0
    def to_uvq
      UVQ.new(x, y)
    end

    # return [String]
    # @since 3.0.0
    def to_s
      "#{self.class.name.split('::').last}(#{x.to_f}, #{y.to_f})"
    end

    # return [String]
    # @since 3.0.0
    def inspect
      "#{self.class.name}(#{x.to_f}, #{y.to_f}, #{z.to_f})"
    end

  end


  # Alias to make code more readable.
  #
  # The SketchUp Ruby API deal with `Geom::Point3d` objects when it comes to
  # UV mapping. But this can make it hard to read the intent of the code when
  # everything is a `Geom::Point3d`.
  #
  # @since 3.0.0
  class UVQ < Geom::Point3d

    # @param [UV, Geom::Point3d] uv
    # @since 3.0.0
    def self.from_uv(uv)
      unless uv.z == 0.0 || uv.z == 1.0 # rubocop:disable Lint/FloatComparison
        raise ArgumentError, "Q is not 1.0, was: #{uv.z.to_f}"
      end

      self.new(uv.x, uv.y)
    end

    # @param [Float] x
    # @param [Float] y
    # @param [Float] z
    # @since 3.0.0
    def initialize(x, y, z = 1.0)
      super(x, y, z)
    end

    # @since 3.0.0
    alias u x

    # @since 3.0.0
    alias v y

    # @since 3.0.0
    alias q z

    # @return [UV]
    # @since 3.0.0
    def to_uv
      UV.from_uvq(self)
    end

    # return [String]
    # @since 3.0.0
    def to_s
      "#{self.class.name.split('::').last}(#{x.to_f}, #{y.to_f}, #{z.to_f})"
    end

    # return [String]
    # @since 3.0.0
    def inspect
      "#{self.class.name}(#{x.to_f}, #{y.to_f}, #{z.to_f})"
    end

  end # class

end # module
