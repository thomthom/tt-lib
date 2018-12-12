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
    def from_uvq(uvq)
      new(uvq.x / uvq.z, y / uvq.z)
    end

    # @param [Float] x
    # @param [Float] y
    # @since 3.0.0
    def initialize(x, y)
      super(x, y, 1.0)
    end

    # @return [UVQ]
    # @since 3.0.0
    def to_uvq
      UVQ.new(x, y)
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

    # @param [Float] x
    # @param [Float] y
    # @param [Float] z
    # @since 3.0.0
    def initialize(x, y, z = 1.0)
      super(x, y, z)
    end

    # @return [UV]
    # @since 3.0.0
    def to_uv
      UV.from_uvq(self)
    end

  end # class

end # module
