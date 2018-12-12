module SkippyLib
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
  #
  # @since 3.0.0
  class UVMapping

    # @since 3.0.0
    def initialize
      @mapping = []
    end

    # @param [Geom::Point3d] model_point
    # @param [UV] uv
    # @return [nil]
    # @since 3.0.0
    def add(model_point, uv)
      @mapping << model_point
      @mapping << uv
      nil
    end

    # @return [Array<Geom::Point3d, UV>]
    # @since 3.0.0
    def to_a
      @mapping
    end

    # @return [Array<Geom::Point3d, UV>]
    # @since 3.0.0
    def to_ary
      # TODO: Remove this? This object doesn't really behave like an array.
      #   It was added as an attempt to avoid calling .to_a when passing on to
      #   face.position_material.
      @mapping
    end

  end # class
end # module
