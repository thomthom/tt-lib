# frozen_string_literal: true

module SkippyLib
  # @since 3.0.0
  class Plane < Array

    # @param [Geom::Point3d] point
    # @param [Geom::Vector3d] vector
    # @since 3.0.0
    def initialize(point, vector)
      super()
      push(point)
      push(vector)
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

    # @since 3.0.0
    def inspect
      "#{self.class.name}#{super}"
    end

  end
end # module
