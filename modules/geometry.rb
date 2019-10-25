# frozen_string_literal: true
module SkippyLib
  # @since 3.0.0
  module Geometry

    extend self

    # @overload midpoint(edge)
    #   @param [Sketchup::Edge] edge
    #   @return [Geom::Point3d]
    #
    # @overload midpoint(point1, point2)
    #   @param [Geom::Point3d] point1
    #   @param [Geom::Point3d] point2
    #   @return [Geom::Point3d]
    #
    # @since 3.0.0
    def mid_point(*args)
      case args.size
      when 1 # Edge
        points = args.first.vertices.map(&:position)
      when 2 # Points
        points = args
      else
        raise ArgumentError, "wrong number of arguments (#{args.size} for 1..2)"
      end
      Geom.linear_combination(0.5, points.first, 0.5, points.last)
    end

    # @param [Array<Geom::Point3d>] points
    # @param [Geom::Vector3d] vector
    # @return [Array<Geom::Point3d>]
    # @since 3.0.0
    def offset_points(points, vector)
      points.map { |point| point.offset(vector) }
    end

  end # class
end # module
