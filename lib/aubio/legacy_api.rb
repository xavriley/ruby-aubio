# frozen_string_literal: true

require 'ffi'

module Aubio
  module LegacyApi #:nodoc
    extend FFI::Library
    # idea inspired by https://github.com/qoobaa/magic/blob/master/lib/magic/api.rb
    lib_paths = Array(ENV['AUBIO_LIB'] || Dir['/{opt,usr}/{,local/}{lib,lib64,Cellar/aubio**,lib/arm-linux-gnueabihf}/libaubio.{*.dylib,so.*}'])
    fallback_names = %w[libaubio.4.2.2.dylib libaubio.so.1 aubio1.dll]
    ffi_lib(lib_paths + fallback_names)

    # tempo
    attach_function :new_aubio_tempo, %i[string int int int], :pointer
    attach_function :aubio_tempo_do, %i[pointer pointer pointer], :void
    attach_function :aubio_tempo_get_last, [:pointer], :int
    attach_function :aubio_tempo_get_last_s, [:pointer], :float
    attach_function :aubio_tempo_get_last_ms, [:pointer], :float
    attach_function :aubio_tempo_set_silence, %i[pointer float], :int
    attach_function :aubio_tempo_get_silence, [:pointer], :float
    attach_function :aubio_tempo_set_threshold, %i[pointer float], :int
    attach_function :aubio_tempo_get_threshold, [:pointer], :float
    attach_function :aubio_tempo_get_bpm, [:pointer], :float
    attach_function :aubio_tempo_get_confidence, [:pointer], :float
    attach_function :del_aubio_tempo, [:pointer], :void

    # beattracking / misc
    attach_function :new_aubio_beattracking, %i[int int int], :pointer
    attach_function :aubio_beattracking_do, %i[pointer pointer pointer], :void
    attach_function :aubio_beattracking_get_bpm, [:pointer], :float
    attach_function :aubio_filter_do, %i[pointer pointer], :void
    attach_function :new_aubio_filter_a_weighting, [:int], :pointer

    # source
    attach_function :new_aubio_source, %i[string int int], :pointer
    attach_function :aubio_source_do, %i[pointer pointer pointer], :void
    attach_function :aubio_source_do_multi, %i[pointer pointer pointer], :void
    attach_function :aubio_source_get_samplerate, [:pointer], :int
    attach_function :aubio_source_get_channels, [:pointer], :int
    attach_function :aubio_source_seek, %i[pointer int], :int
    attach_function :aubio_source_close, [:pointer], :int
    attach_function :del_aubio_source, [:pointer], :void

    # sink
    attach_function :new_aubio_sink, %i[string int], :pointer
    attach_function :aubio_sink_preset_samplerate, %i[pointer int], :void
    attach_function :aubio_sink_preset_channels, %i[pointer int], :void
    attach_function :aubio_sink_get_samplerate, [:pointer], :int
    attach_function :aubio_sink_get_channels, [:pointer], :int
    attach_function :aubio_sink_do, %i[pointer pointer int], :void
    attach_function :aubio_sink_do_multi, %i[pointer pointer int], :void
    attach_function :aubio_sink_close, [:pointer], :int
    attach_function :del_aubio_sink, [:pointer], :void

    # onset
    attach_function :new_aubio_onset, %i[string int int int], :pointer
    attach_function :aubio_onset_do, %i[pointer pointer pointer], :void
    attach_function :aubio_onset_get_last, [:pointer], :int
    attach_function :aubio_onset_get_last_s, [:pointer], :float
    attach_function :aubio_onset_get_last_ms, [:pointer], :float
    attach_function :aubio_onset_set_silence, %i[pointer float], :int
    attach_function :aubio_onset_get_silence, [:pointer], :float
    attach_function :aubio_onset_get_descriptor, [:pointer], :float
    attach_function :aubio_onset_get_thresholded_descriptor, [:pointer], :float
    attach_function :aubio_onset_set_threshold, %i[pointer float], :int
    attach_function :aubio_onset_set_minioi, %i[pointer int], :int
    attach_function :aubio_onset_set_minioi_s, %i[pointer int], :int
    attach_function :aubio_onset_set_minioi_ms, %i[pointer float], :int
    attach_function :aubio_onset_set_delay, %i[pointer int], :int
    attach_function :aubio_onset_set_delay_s, %i[pointer int], :int
    attach_function :aubio_onset_set_delay_ms, %i[pointer float], :int
    attach_function :aubio_onset_get_minioi, [:pointer], :int
    attach_function :aubio_onset_get_minioi_s, [:pointer], :float
    attach_function :aubio_onset_get_minioi_ms, [:pointer], :float
    attach_function :aubio_onset_get_delay, [:pointer], :int
    attach_function :aubio_onset_get_delay_s, [:pointer], :float
    attach_function :aubio_onset_get_delay_ms, [:pointer], :float
    attach_function :aubio_onset_get_threshold, [:pointer], :float
    attach_function :del_aubio_onset, [:pointer], :void

    # pitch
    attach_function :new_aubio_pitch, %i[string int int int], :pointer
    attach_function :aubio_pitch_do, %i[pointer pointer pointer], :void
    attach_function :aubio_pitch_set_tolerance, %i[pointer int], :int
    attach_function :aubio_pitch_set_unit, %i[pointer string], :int
    attach_function :aubio_pitch_set_silence, %i[pointer float], :int
    attach_function :aubio_pitch_get_silence, [:pointer], :float
    attach_function :aubio_pitch_get_confidence, [:pointer], :float
    attach_function :del_aubio_pitch, [:pointer], :void

    # new fvec
    attach_function :new_fvec, [:int], :pointer
    attach_function :del_fvec, [:pointer], :void
    attach_function :fvec_get_sample, %i[pointer int], :float
    attach_function :fvec_set_sample, %i[pointer float int], :void
    attach_function :fvec_get_data, [:pointer], :float
    attach_function :fvec_print, [:pointer], :void
    attach_function :fvec_set_all, %i[pointer float], :void
    attach_function :fvec_zeros, [:pointer], :void
    attach_function :fvec_rev, [:pointer], :void
    attach_function :fvec_weight, %i[pointer pointer], :void
    attach_function :fvec_copy, %i[pointer pointer], :void
    attach_function :fvec_ones, [:pointer], :void
  end
end
