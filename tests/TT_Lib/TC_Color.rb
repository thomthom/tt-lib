# frozen_string_literal: true

require 'testup/testcase'

require 'modules/color'

module SkippyLib
  class TC_Color < TestUp::TestCase

    def setup
      # ...
    end

    def teardown
      # ...
    end


    def test_initialize
      color = Color.new(64, 128, 192, 32)
      assert_kind_of(Color, color)
      assert_kind_of(Sketchup::Color, color)
      assert_equal(64, color.red)
      assert_equal(128, color.green)
      assert_equal(192, color.blue)
      assert_equal(32, color.alpha)
    end


    def test_grayscale_Query_is_grayscale
      color = Color.new(64, 64, 64, 255)
      assert(color.grayscale?)
    end

    def test_grayscale_Query_is_transparent_grayscale
      color = Color.new(64, 64, 64, 32)
      assert(color.grayscale?)
    end

    def test_grayscale_Query_is_not_grayscale
      color = Color.new(64, 128, 192, 255)
      refute(color.grayscale?)
    end


    def test_luminance
      color = Color.new(64, 128, 192)
      assert_equal(116, color.luminance)
    end

    def test_luminance_transparent
      color = Color.new(64, 128, 192, 32)
      assert_equal(116, color.luminance)
    end

    def test_luminance_black
      color = Color.new(0, 0, 0)
      assert_equal(0, color.luminance)
    end

    def test_luminance_white
      color = Color.new(255, 255, 255)
      assert_equal(255, color.luminance)
    end

    def test_luminance_semi_dark
      color = Color.new(40, 20, 30)
      assert_equal(27, color.luminance)
    end

    def test_luminance_semi_light
      color = Color.new(210, 220, 230)
      assert_equal(218, color.luminance)
    end


    def test_r
      color = Color.new(64, 128, 192, 32)
      assert_equal(64, color.r)
    end


    def test_g
      color = Color.new(64, 128, 192, 32)
      assert_equal(128, color.g)
    end


    def test_b
      color = Color.new(64, 128, 192, 32)
      assert_equal(192, color.b)
    end


    def test_a
      color = Color.new(64, 128, 192, 32)
      assert_equal(32, color.a)
    end

  end
end
