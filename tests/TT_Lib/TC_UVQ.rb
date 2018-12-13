require 'testup/testcase'

require 'modules/uv'

module SkippyLib
  class TC_UVQ < TestUp::TestCase

    def setup
      # ...
    end

    def teardown
      # ...
    end


    def test_initialize_three_floats
      uvq = UVQ.new(0.5, 0.25, 0.75)
      assert_kind_of(UVQ, uvq)
      assert_kind_of(Geom::Point3d, uvq)
      assert_equal(0.5, uvq.u)
      assert_equal(0.25, uvq.v)
      assert_equal(0.75, uvq.q)
    end

    def test_initialize_two_floats
      uvq = UVQ.new(0.5, 0.25)
      assert_kind_of(UVQ, uvq)
      assert_kind_of(Geom::Point3d, uvq)
      assert_equal(0.5, uvq.u)
      assert_equal(0.25, uvq.v)
      assert_equal(1.0, uvq.q)
    end

    def test_initialize_too_many_arguments
      assert_raises(ArgumentError) do
        UV.new(0.5, 0.25, 0.5, 0.75)
      end
    end


    def test_from_uv
      uv = UV.new(1.5, 2.0)
      uvq = UVQ.from_uv(uv)
      assert_kind_of(UVQ, uvq)
      assert_equal(1.5, uvq.u)
      assert_equal(2.0, uvq.v)
      assert_equal(1.0, uvq.q)
    end

    def test_from_uv_point3d
      uv_point = Geom::Point3d.new(1.5, 2.0)
      uvq = UVQ.from_uv(uv_point)
      assert_kind_of(UVQ, uvq)
      assert_equal(1.5, uvq.u)
      assert_equal(2.0, uvq.v)
      assert_equal(1.0, uvq.q)
    end

    def test_from_uv_point3d_where_q_is_not_one
      uv_point = Geom::Point3d.new(1.5, 2.0, 0.5)
      assert_raises(ArgumentError) do
        UVQ.from_uv(uv_point)
      end
    end


    def test_u
      uvq = UVQ.new(0.5, 0.25, 0.75)
      assert_equal(0.5, uvq.u)
    end


    def test_v
      uvq = UVQ.new(0.5, 0.25, 0.75)
      assert_equal(0.25, uvq.v)
    end


    def test_q
      uvq = UVQ.new(0.5, 0.25, 0.75)
      assert_equal(0.75, uvq.q)
    end


    def test_to_uv
      uvq = UVQ.new(1.5, 2.0, 0.5)
      uv = uvq.to_uv
      assert_kind_of(UV, uv)
      assert_equal(3.0, uv.u)
      assert_equal(4.0, uv.v)
      assert_equal(1.0, uv.q)
    end


    def test_to_s
      uvq = UVQ.new(0.5, 0.25, 0.75)
      result = uvq.to_s
      assert_kind_of(String, result)
      assert_equal('UVQ(0.5, 0.25, 0.75)', result)
    end


    def test_inspect
      uvq = UVQ.new(0.5, 0.25, 0.75)
      result = uvq.inspect
      assert_kind_of(String, result)
      assert_equal('SkippyLib::UVQ(0.5, 0.25, 0.75)', result)
    end

  end
end
