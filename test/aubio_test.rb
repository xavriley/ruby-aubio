require 'test_helper'

class AubioTest < Minitest::Test
  def setup
    @loop_amen_path = File.expand_path("../sounds/loop_amen.wav", __FILE__)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Aubio::VERSION
  end

  def test_it_checks_file_existence
    assert_raises Aubio::FileNotFound do
      result = Aubio.open(@loop_amen_path + "e")
    end
  end

  def test_it_checks_file_is_readable_audio
    assert_raises Aubio::InvalidAudioInput do
      Aubio.open("/Users/xriley/Projects/aubio/Gemfile")
    end
  end

  def test_it_checks_if_file_has_been_closed
    source = Aubio.open(@loop_amen_path)
    source.close
    assert_raises Aubio::AlreadyClosed do
      source.onsets
    end
  end

  def test_it_calculates_onsets
    #loltdd
    result = Aubio.open(@loop_amen_path).onsets.first(10)
    refute_nil result
  end
end
