# frozen_string_literal: true

require 'testup/testcase'

require 'modules/geometry'

module SkippyLib
  class TC_Geometry < TestUp::TestCase

    def setup
      # ...
    end

    def teardown
      # ...
    end


    def test_mixin
      klass = Class.new do
        include Geometry
      end
      klass.is_a?(Geometry)
      klass.new.mid_point([0, 0, 0], [2, 2, 2])
    end


    def test_mid_point_points
      point1 = Geom::Point3d.new(1, 2, 4)
      point2 = Geom::Point3d.new(4, 12, 8)
      mid_point = Geometry.mid_point(point1, point2)
      assert_kind_of(Geom::Point3d, mid_point)
      assert_equal(Geom::Point3d.new(2.5, 7, 6), mid_point)
    end

    def test_mid_point_edge
      model = start_with_empty_model
      point1 = Geom::Point3d.new(1, 2, 4)
      point2 = Geom::Point3d.new(4, 12, 8)
      edge = model.entities.add_line(point1, point2)
      mid_point = Geometry.mid_point(edge)
      assert_kind_of(Geom::Point3d, mid_point)
      assert_equal(Geom::Point3d.new(2.5, 7, 6), mid_point)
    end

    def test_mid_point_too_few_arguments
      assert_raises(ArgumentError) do
        Geometry.mid_point
      end
    end

    def test_mid_point_too_many_arguments
      assert_raises(ArgumentError) do
        Geometry.mid_point([0, 0, 0], [1, 1, 1], [2, 2, 2])
      end
    end


    def test_offset_points
      points = [
        Geom::Point3d.new(0, 0, 0),
        Geom::Point3d.new(2, 5, 8),
        Geom::Point3d.new(6, 2, 3),
      ]
      vector = Geom::Vector3d.new(1, 2, -2)
      result = Geometry.offset_points(points, vector)
      expected = [
        Geom::Point3d.new(1, 2, -2),
        Geom::Point3d.new(3, 7, 6),
        Geom::Point3d.new(7, 4, 1),
      ]
      assert_kind_of(Array, result)
      result.each { |point|
        assert_kind_of(Geom::Point3d, point)
      }
      assert_equal(expected, result)
    end

  end
end
