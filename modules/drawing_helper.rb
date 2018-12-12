require 'modules/gl/constants'

module SkippyLib
  # @since 3.0.0
  module DrawingHelper

    extend self

    # @param [Array<Geom::Point3d>] points
    # @param [Boolean] mid_pixel
    # @return [Array<Geom::Point3d>]
    # @since 3.0.0
    def adjust_to_pixel_grid(points, mid_pixel = false)
      points.map { |point|
        point.x = point.x.to_i
        point.y = point.y.to_i
        point.z = point.z.to_i
        if mid_pixel
          point.x -= 0.5
          point.y -= 0.5
          point.z -= 0.5
        end
        point
      }
    end

    # @param [Sketchup::View] view
    # @param [Geom::Point3d] point
    # @return [Geom::Point3d]
    # @since 3.0.0
    def offset_toward_camera(view, point)
      # Model.pixels_to_model converts argument to integers. So in order to get
      # a fraction we compute that from the result.
      size = view.pixels_to_model(1, point) * 0.01
      point.offset(view.camera.direction.reverse!, size)
    end

    # Ensures the given screen point is adjusted to the screen pixel grid.
    # Drawing odd width lines require the pixel coordinate to be in the centre
    # of the pixel in order for it to be drawn crisp when anti-aliasing is
    # enabled.
    #
    # @since 3.0.0
    def screen_point(screen_point, line_width)
      odd_line_width = line_width.to_i % 2 == 1
      adjustment = (odd_line_width) ? 0.5 : 0.0
      corrected_point = screen_point.clone
      corrected_point.x = corrected_point.x.to_i + adjustment
      corrected_point.y = corrected_point.y.to_i + adjustment
      corrected_point.z = 0.0
      corrected_point
    end

    # @param [Sketchup::View] view
    # @param [Enumerable<Sketchup::Edge>] edges
    # @param [Integer] width
    # @param [Sketchup::Color] color
    # @since 3.0.0
    def draw_edges(view, edges, width = 1, color = nil)
      color ||= view.model.rendering_options['ForegroundColor']
      points = edges.map { |edge|
        edge.vertices.map { |vertex|
          offset_toward_camera(view, vertex.position)
        }
      }
      points.flatten!
      view.drawing_color = color
      view.line_width = width
      view.line_stipple = ""
      view.draw(GL_LINES, points)
      nil
    end

    # Because the SU API doesn't let one set the Point size and style when
    # drawing 3D points the vertices are simulated by using GL_LINES instead.
    # There is a slight overhead by generating the new points like this, but
    # it's the only solution at the moment.
    #
    # @param [Sketchup::View] view
    # @param [Enumerable<Sketchup::Vertex>] vertices
    # @param [Integer] size
    # @return [Nil]
    # @since 3.0.0
    def draw_points(view, points, size)
      return nil if points.empty?

      segments = []
      # Draw each point as a line segment. It's currently a workaround as the
      # SketchUp Ruby API doesn't give enough control for drawing points.
      camera_right = view.camera.direction.axes.x
      camera_left = camera_right.reverse
      toward_camera = view.camera.direction.reverse
      # Offset the points a little bit so they don't disappear into the
      # mesh. The offset distance is picked by experimenting with what looked
      # good. It might not scale properly for all sizes.
      screen_offset_distance = (size / 3.0).to_i
      points.each { |point|
        point = point.position if point.is_a?(Sketchup::Vertex)
        # Calculate the offset position for the vertex relative to the camera.
        offset_distance = view.pixels_to_model(screen_offset_distance, point)
        camera_point = point.offset(toward_camera, offset_distance)
        # Calculate the world coordinates for the vertex in order to draw it in
        # the given screen size.
        offset = view.pixels_to_model(size / 2.0, camera_point)
        segments << camera_point.offset(camera_left, offset)
        segments << camera_point.offset(camera_right, offset)
      }
      view.line_stipple = ''
      view.line_width = size
      view.draw(GL_LINES, segments)
      nil
    end

    # Draw 2D squares which are adjusted to the pixel grid.
    #
    # @param [Sketchup::View] view
    # @param [Enumerable<Sketchup::Vertex>] vertices
    # @param [Integer] size
    # @return [Nil]
    # @since 3.0.0
    def draw2d_points(view, point, size)
      half_size = size / 2.0
      # rubocop:disable Layout/SpaceInsideArrayLiteralBrackets
      points = [
        point.offset([-half_size, -half_size, 0]),
        point.offset([ half_size, -half_size, 0]),
        point.offset([ half_size,  half_size, 0]),
        point.offset([-half_size,  half_size, 0]),
      ]
      # rubocop:enable Layout/SpaceInsideArrayLiteralBrackets
      points = adjust_to_pixel_grid(points)
      view.draw2d(GL_QUADS, points)
      nil
    end

  end # class
end # module
