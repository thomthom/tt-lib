Sketchup.require 'modules/boundingbox_constants'
Sketchup.require 'modules/object_utils'

module SkippyLib
  # This class is different from Geom::BoundingBox because it represent the
  # orientation in model space. The visible boundingbox one see in the viewport.
  #
  # @since 3.0.0
  class BoundingBox

    include BoundingBoxConstants
    include ObjectUtils

    # @since 3.0.0
    attr_reader :points

    # @param [Array<Geom::Point3d>] points 0, 4 or 8 3d points.
    # @since 3.0.0
    def initialize(points)
      unless [0, 4, 8].include?(points.size)
        raise ArgumentError, "Expected 0, 4 or 8 points (#{points.size} given)"
      end

      @points = points
    end


    # @since 3.0.0
    def empty?
      @points.empty?
    end


    # @since 3.0.0
    def is_2d? # rubocop:disable Naming/PredicateName
      @points.size == 4
    end

    # @since 3.0.0
    def is_3d? # rubocop:disable Naming/PredicateName
      @points.size == 8
    end


    # @since 3.0.0
    def have_area? # rubocop:disable Naming/PredicateName
      x_axis.valid? && y_axis.valid?
    end

    # @since 3.0.0
    def have_volume? # rubocop:disable Naming/PredicateName
      x_axis.valid? && y_axis.valid? && z_axis.valid?
    end


    # @since 3.0.0
    def width
      x_axis.length
    end

    # @since 3.0.0
    def height
      y_axis.length
    end

    # @since 3.0.0
    def depth
      z_axis.length
    end


    # @since 3.0.0
    def origin
      @points[BOTTOM_FRONT_LEFT]
    end


    # @since 3.0.0
    def x_axis
      @points[BOTTOM_FRONT_LEFT].vector_to(@points[BOTTOM_FRONT_RIGHT])
    end

    # @since 3.0.0
    def y_axis
      @points[BOTTOM_FRONT_LEFT].vector_to(@points[BOTTOM_BACK_LEFT])
    end

    # @since 3.0.0
    def z_axis
      @points[BOTTOM_FRONT_LEFT].vector_to(@points[TOP_FRONT_LEFT])
    end


    # @since 3.0.0
    def draw(view)
      view.draw(GL_LINE_LOOP, @points[0..3])
      if is_3d?
        view.draw(GL_LINE_LOOP, @points[4..7])
        connectors = [
          @points[0], @points[4],
          @points[1], @points[5],
          @points[2], @points[6],
          @points[3], @points[7],
        ]
        view.draw(GL_LINES, connectors)
      end
    end

  end # class
end # module
