# frozen_string_literal: true
require 'testup/testcase'

require 'modules/line'

module SkippyLib
  class TC_Line < TestUp::TestCase

    def setup
      # ...
    end

    def teardown
      # ...
    end


    def test_initialize_point_vector
      point = Geom::Point3d.new(10, 20, 30)
      vector = Geom::Vector3d.new(3, 2, 1)
      line = Line.new(point, vector)
      assert_kind_of(Line, line)
      assert_kind_of(Array, line)
      assert_equal([point, vector], line.to_a)
    end

    def test_initialize_two_points
      point1 = Geom::Point3d.new(10, 20, 30)
      point2 = Geom::Point3d.new(15, 30, 55)
      vector = Geom::Vector3d.new(5, 10, 25).normalize
      line = Line.new(point1, point2)
      assert_kind_of(Line, line)
      assert_kind_of(Array, line)
      assert_equal([point, vector], line.to_a)
    end


    def test_direction
      point1 = Geom::Point3d.new(10, 20, 30)
      point2 = Geom::Point3d.new(15, 30, 55)
      vector = Geom::Vector3d.new(5, 10, 25).normalize
      line = Line.new(point1, point2)
      result = line.direction
      assert_kind_of(Geom::Vector3d, result)
      assert_equal(vector, result)
    end

    def test_direction_array_vector
      point = Geom::Point3d.new(10, 20, 30)
      vector = Geom::Vector.new(1, 2, 3)
      # This case is a little ambigous, as array can substitute both points and
      # vectors. #direction will assume vector.
      # TODO: Check how SketchUp deal with this.
      line = Line.new(point, [1, 2, 3])
      result = line.direction
      assert_kind_of(Geom::Vector3d, result)
      assert_equal(vector, result)
    end

    def test_direction_cached_value
      point1 = Geom::Point3d.new(10, 20, 30)
      point2 = Geom::Point3d.new(15, 30, 55)
      line = Line.new(point1, point2)
      result1 = line.direction
      result2 = line.direction
      assert_equal(result1.object_id, result2.object_id)
    end


    def test_valid_Query_valid_point_vector
      point = Geom::Point3d.new(10, 20, 30)
      vector = Geom::Vector3d.new(1, 2, 3)
      line = Line.new(point, vector)
      assert(line.valid?)
    end

    def test_valid_Query_valid_array_point_vector
      vector = Geom::Vector3d.new(1, 2, 3)
      line = Line.new([10, 20, 30], vector)
      assert(line.valid?)
    end

    def test_valid_Query_valid_point_array_vector
      point = Geom::Point3d.new(10, 20, 30)
      line = Line.new(point, [1, 2, 3])
      assert(line.valid?)
    end

    def test_valid_Query_invalid
      point = Geom::Point3d.new(10, 20, 30)
      line = Line.new(point, nil)
      refute(line.valid?)
    end

  end
end
