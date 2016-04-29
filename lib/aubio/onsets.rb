module Aubio
	class Onsets

		def initialize(aubio_source, params)
      # TODO: cleanup param dups
			@sample_rate = params[:sample_rate] || 44100
			@window_size = params[:window_size] || 1024
			@hop_size    = params[:hop_size]    || 512

			@source = aubio_source
			@onset = Api.new_aubio_onset('default', @window_size, @hop_size, @sample_rate)
			Api.aubio_onset_set_minioi_ms(@onset, 12.0)
			Api.aubio_onset_set_threshold(@onset, 0.3)

			# create output for source
			@sample_buffer = Api.new_fvec(@hop_size)
			# create output for pitch and beat
			@out_fvec = Api.new_fvec(1)
		end

		def each
			return enum_for(:each) unless block_given?

			total_frames_counter = 0
			tmp_read = FFI::MemoryPointer.new(:int)

			loop do
				# Perform onset calculation
        Api.aubio_source_do(@source, @sample_buffer, tmp_read)
				Api.aubio_onset_do(@onset, @sample_buffer, @out_fvec)

        # Retrieve result
				onset_new_peak = Api.fvec_get_sample(@out_fvec, 0)

        if onset_new_peak > 0.0
					onset_seconds = Api.aubio_onset_get_last_s(@onset)
					onset_milliseconds = Api.aubio_onset_get_last_ms(@onset)
          # TODO: implement relative here
					output = {
            :s => onset_seconds,
            :ms => onset_milliseconds
					}
          yield output
				end

				read = tmp_read.read_int
				total_frames_counter += read
				if(read != @hop_size) then
          # clean up
          Api.del_aubio_source(@source)
					Api.del_fvec(@sample_buffer)
					Api.del_fvec(@out_fvec)

					break
				end
			end
		end

	end
end
