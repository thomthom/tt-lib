require 'testup/testcase'

require 'modules/uv'

module SkippyLib
  class TC_UV < TestUp::TestCase

    def setup
      # ...
    end

    def teardown
      # ...
    end


    def test_initialize
      uv = UV.new(0.5, 0.25)
      assert_kind_of(UV, uv)
      assert_kind_of(Geom::Point3d, uv)
      assert_equal(0.5, uv.u)
      assert_equal(0.25, uv.v)
      assert_equal(1.0, uv.q)
    end

    def test_initialize_too_many_arguments
      assert_raises(ArgumentError) do
        UV.new(0.5, 0.25, 0.5)
      end
    end


    def test_from_uvq
      uvq = UVQ.new(1.5, 2.0, 0.5)
      uv = UV.from_uvq(uvq)
      assert_kind_of(UV, uv)
      assert_equal(3.0, uv.u)
      assert_equal(4.0, uv.v)
      assert_equal(1.0, uv.q)
    end

    def test_from_uvq_point3d
      uvq_point = Geom::Point3d.new(1.5, 2.0, 0.5)
      uv = UV.from_uvq(uvq_point)
      assert_kind_of(UV, uv)
      assert_equal(3.0, uv.u)
      assert_equal(4.0, uv.v)
      assert_equal(1.0, uv.q)
    end


    def test_u
      uv = UV.new(0.5, 0.25)
      assert_equal(0.5, uv.u)
    end


    def test_v
      uv = UV.new(0.5, 0.25)
      assert_equal(0.25, uv.v)
    end


    def test_q
      uvq = UV.new(0.5, 0.25)
      assert_equal(1.0, uvq.q)
    end


    def test_to_uvq
      uv = UV.new(0.5, 0.25)
      uvq = uv.to_uvq
      assert_kind_of(UVQ, uvq)
      assert_equal(0.5, uvq.u)
      assert_equal(0.25, uvq.v)
      assert_equal(1.0, uvq.q)
    end


    def test_to_s
      uv = UV.new(0.5, 0.25)
      result = uv.to_s
      assert_kind_of(String, result)
      assert_equal('UV(0.5, 0.25)', result)
    end


    def test_inspect
      uv = UV.new(0.5, 0.25)
      result = uv.inspect
      assert_kind_of(String, result)
      assert_equal('SkippyLib::UV(0.5, 0.25, 1.0)', result)
    end

  end
end
