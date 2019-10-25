# tt-lib³

A [skippy](https://github.com/thomthom/skippy) library for SketchUp

## Beware: Work in Progress!

This project is in very early stage of development. Experimental. Pre-alpha. Anything might change at any given time until a stable release has been announced.

## Intent

This is a general purpose Ruby library for SketchUp extensions.

Previous incarnations of tt-lib was distributed as an `.rbz`, identically to any normal extension. By it self it did nothing, but a number of extensions depended on it to be installed. This was convent for development, but not for maintenance or end users.

### Long Term

The long term goal for tt-lib³ is to become a [skippy](https://github.com/thomthom/skippy) library. Skippy will - in time - manage library dependencies for SketchUp extension projects; Installing, updating etc. While making sure the consumed libraries are embedded into the extension package and namespace.

### Short Term

Until skippy is more mature, this library can be used as a resource and a reference point for small utility classes and methods useful in common SketchUp extension development.

## Design Philosophy

### Short and Sweet

The library will consist of a number of small generic classes and modules designed for their own specific purpose.

Objects that holds state are implemented at classes, while stateless functionality is put into mix-in-able modules.

### Mix-in-able modules

Modules in this library `include self`, so you can use their methods by calling them on the module itself, or by including it into your current scope.

Example: (As a mix-in)

```ruby
require 'example/vendor/tt-lib/drawing_helper'

module Example
  class CustomTool

    include DrawingHelper

    def draw(view)
      draw_points(view, points, size)
      draw_edges(view, edges, 2, 'red')
    end

  end
end
```

Example: (As a separate module reference)

```ruby
require 'example/vendor/tt-lib/drawing_helper'

module Example
  class CustomTool

    def draw(view)
      DrawingHelper.draw_points(view, points, size)
      DrawingHelper.draw_edges(view, edges, 2, 'red')
    end

  end
end
```

### Tested

Each module, class and methods should have tests that verify their behavior.

### [Documented](https://www.rubydoc.info/github/thomthom/tt-lib/master)

Each module, class and methods should have [documentation](https://www.rubydoc.info/github/thomthom/tt-lib/master) for what it does, it's parameters, it's types and examples.

### Consistent

RuboCop enforces coding style and linting for code consistency.
