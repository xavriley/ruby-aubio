require 'test_helper'

class AubioTest < Minitest::Test
  def setup
    @loop_amen_path = File.expand_path("../sounds/loop_amen.wav", __FILE__)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Aubio::VERSION
  end

  def test_it_calculates_onsets
    #loltdd
    result = Aubio.open(@loop_amen_path).onsets.first(10)
    refute_nil result
  end
end
