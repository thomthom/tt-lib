module SkippyLib

  # Alias to make code more readable.
  #
  # The SketchUp Ruby API deal with {Geom::Point3d} objects when it comes to
  # UV mapping. But this can make it hard to read the intent of the code when
  # everything is a {Geom::Point3d}.
  class UV < Geom::Point3d; end

  # Simple structure to make it more readable to build the UV mapping array
  # for {Sketchup::Face#position_material}.
  #
  # @example
  #   mapping = UVMapping.new
  #   mapping.add(points[0], UV.new(0, 0))
  #   mapping.add(points[1], UV.new(1, 0))
  #   mapping.add(points[2], UV.new(1, 1))
  #   mapping.add(points[3], UV.new(0, 1))
  #   face.position_material(material, mapping.to_a, true)
  class UVMapping

    def initialize
      @mapping = []
    end

    # @param [Geom::Point3d] model_point
    # @param [UV] uv
    # @return [nil]
    def add(model_point, uv)
      @mapping << model_point
      @mapping << uv
      nil
    end

    # @return [Array<Geom::Point3d, UV>]
    def to_a
      @mapping
    end

    # @return [Array<Geom::Point3d, UV>]
    def to_ary
      @mapping
    end

  end # class

end # module
