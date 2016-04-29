require_relative "aubio/version"
require_relative "aubio/api"
require_relative "aubio/onsets"

module Aubio
  class Base
    class FileNotFound < Exception; end

    def initialize(path, params)
      raise FileNotFound unless File.file?(path)

			sample_rate = params[:sample_rate] || 44100
			hop_size    = params[:hop_size]    || 512

			@source = Api.new_aubio_source(path, sample_rate, hop_size)
      @params = params
    end

    def onsets
      Onsets.new(@source, @params).each
    end
  end
end

module Aubio
  def self.open(path, params = {})
    Base.new(path, params)
  end
end
