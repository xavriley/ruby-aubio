require_relative "aubio/version"
require_relative "aubio/api"
require_relative "aubio/onsets"
require_relative "aubio/pitches"

module Aubio
  class AubioException < Exception; end
  class FileNotFound < AubioException; end
  class AlreadyClosed < AubioException; end
  class InvalidAudioInput < AubioException; end

  class Base
    def initialize(path, params)
      raise FileNotFound unless File.file?(path)

			sample_rate = params[:sample_rate] || 44100
			hop_size    = params[:hop_size]    || 512

			@source = Api.new_aubio_source(path, sample_rate, hop_size)
      @params = params

      check_for_valid_audio_source(path)
    end

    def close
      Api.del_aubio_source(@source)
      @is_closed = true
    end

    def onsets
      check_for_closed

      Onsets.new(@source, @params).each
    end

    def pitches
      check_for_closed

      Pitches.new(@source, @params).each
    end

    private
    def check_for_closed
      raise AlreadyClosed if @is_closed
    end

    def check_for_valid_audio_source(path)
      begin
        @source.read_pointer
      rescue FFI::NullPointerError
        raise InvalidAudioInput.new(%Q{

            Couldn't read file at #{path}
            Did you install aubio with libsndfile support?
          })
      end
    end
  end
end

module Aubio
  def self.open(path, params = {})
    Base.new(path, params)
  end
end
