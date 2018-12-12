Sketchup.require 'modules/object_utils'

module SkippyLib
  # Caches drawing instructions so complex calculations for generating the
  # GL data can be reused.
  #
  # Redirect all `Skethcup::View` commands to a {DrawingCache} object and call
  # `#render` in a Tool's `#draw` event.
  #
  # @example
  #   class ExampleTool
  #     def initialize(model)
  #       @draw_cache = DrawCache.new(model.active_view)
  #     end
  #     def deactivate(view)
  #       @draw_cache.clear
  #     end
  #     def resume(view)
  #       view.invalidate
  #     end
  #     def onLButtonUp(flags, x, y, view)
  #       point = Geom::Point3d.new(x, y, 0)
  #       view.draw_points(point, 10, 1, 'red')
  #       view.invalidate
  #     end
  #     def draw(view)
  #       @draw_cache.render
  #     end
  #   end
  #
  # @since 3.0.0
  class DrawingCache

    include ObjectUtils

    # @param [Sketchup::View] view
    # @since 3.0.0
    def initialize(view)
      @view = view
      @commands = []
    end

    # Clears the cache. All drawing instructions are removed.
    #
    # @return [Nil]
    # @since 3.0.0
    def clear
      @commands.clear
      nil
    end

    # Draws the cached drawing instructions.
    #
    # @return [Sketchup::View]
    # @since 3.0.0
    def render
      view = @view
      @commands.each { |command|
        view.send(*command)
      }
      view
    end

    # Cache drawing commands and data. These methods received the finsihed
    # processed drawing data that will be executed when {#render} is called.
    [
      :draw,
      :draw2d,
      :draw_line,
      :draw_lines,
      :draw_points,
      :draw_polyline,
      :draw_text,
      :drawing_color=,
      :line_stipple=,
      :line_width=,
      :set_color_from_line,
    ].each { |symbol|
      define_method(symbol) { |*args|
        @commands << args.unshift(__method__)
        @commands.size
      }
    }

    # Pass through methods to `Sketchup::View` so that the drawing cache object
    # can easily replace `Sketchup::View` objects in existing codes.
    def method_missing(method, *args)
      @view.respond_to?(method) ? @view.send(method, *args) : super
    end

    def respond_to_missing?(method, *)
      @view.respond_to?(method) | super
    end

    # @return [String]
    # @since 3.0.0
    def inspect
      inspect_object(commands: @commands.size)
    end

  end # class
end # module
