# frozen_string_literal: true

module SkippyLib
  # @since 3.0.0
  class Line < Array

    # @param [Geom::Point3d] point
    # @param [Geom::Vector3d] vector
    # @since 3.0.0
    def initialize(point, vector)
      super()
      # Not making type check or type conversion due to performance.
      push(point)
      push(vector)
    end

    # @return [Geom::Vector3d]
    # @since 3.0.0
    def direction
      @direction ||= direction_internal
    end

    # @return [Array(Geom::Point3d, Geom::Vector3d)]
    # @since 3.0.0
    def to_a
      [at(0).clone, direction]
    end

    # @since 3.0.0
    def valid?
      valid_point3d?(at(0)) && (valid_point3d?(at(1)) || valid_vector3d?(at(1)))
    end

    # @return [String]
    # @since 3.0.0
    def inspect
      "#{self.class.name}#{super}"
    end

    # Hide Array modifiers.
    private :push, :<<, :pop, :shift, :unshift, :[]=, :concat
    private :delete, :delete_at, :delete_if, :drop, :drop_while, :fill
    private :collect!, :compact!, :flatten!, :map!, :normalize!, :offset!,
        :reject!, :reverse!, :rotate!, :select!, :shuffle!, :slice!, :sort!,
        :sort_by!, :transform!, :uniq!

    # Hide SketchUp API extension to the Array class that doesn't make sense for
    # this class.
    private :x, :y, :z
    private :cross, :dot
    private :distance, :distance_to_line, :distance_to_plane
    private :offset, :vector_to
    private :normalize
    private :on_line?, :on_plane?

    private

    # @return [Geom::Vector3d]
    def direction_internal
      if at(1).is_a?(Geom::Vector3d)
        at(1).normalize
      elsif at(1).is_a?(Array)
        Geom::Vector3d.new(at(1)).normalize
      else
        at(0).vector_to(at(1)).normalize
      end
    end

    # @param [Geom::Point3d, Array(Numeric, Numeric, Numeric)] object
    def valid_point3d?(object)
      object.is_a?(Geom::Point3d) && valid_triple?(object)
    end

    # @param [Geom::Vector3d, Array(Numeric, Numeric, Numeric)] object
    def valid_vector3d?(object)
      object.is_a?(Geom::Vector3d) && valid_triple?(object)
    end

    # @param [Array(Numeric, Numeric, Numeric)] object
    def valid_triple?(object)
      object.is_a?(Array) && object.size == 3 && object.all? { |item|
        item.is_a?(Numeric)
      }
    end

  end
end # module
