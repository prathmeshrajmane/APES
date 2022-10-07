resource "aws_cloudformation_stack" "medialivechannel" {
  name = var.medialive-stack_name
  parameters = {
    SgCidr = var.medialive_input_sg_cidr
    InputName = var.medialive_input_name
    InputCodec = var.medialive_input_codec
    InputResolution = var.medialive_input_resolution
    MaxBitRate = var.medialive_input_maximum_bitrate
    MediaAccessRoleArn = var.media_access_role_arn
    DestinationA = var.input_destination_a
    DestinationB = var.input_destination_b
    MediaLiveChannelName = var.medialive_channel_name
    MediaPackageDestinationId = var.mediapackage_destination_id
    MediaPackageChannelId = var.mediapackage_channel_id
    MediaLiveOutputGroupName = var.medialive_outputgroup_name
    MediaLiveOutPutGroupDestinationId = var.medialive_outputgroup_destination_id
    MediaLiveOutputName = var.medialive_output_name
    MediaLiveVideoDescriptionName = var.videodescription_name
    # Variables related to Video Description
    VideoDescriptionFramerateControl = var.videodescription_framerate_control
    VideoDescriptionParControl = var.videodescription_par_control
    VideoDescriptionFramerateDenominator = var.videodescription_framerate_denominator
    VideoDescriptionFramerateNumerator = var.videodescription_framerate_numerator
    VideoDescriptionAdaptiveQuantization = var.videodescription_adaptive_quantization
    VideoDescriptionAfdSignaling = var.videodescription_afd_signaling
    VideoDescriptionBitrate = var.videodescription_bitrate
    VideoDescriptionColorMetadata = var.videodescription_color_metadata
    VideoDescriptionEntropyEncoding = var.videodescription_entropy_encoding
    VideoDescriptionFlickerAq = var.videodescription_flicker_aq
    VideoDescriptionGopBReference = var.videodescription_gop_b_reference
    VideoDescriptionGopClosedCadence = var.videodescription_gop_closed_cadence
    VideoDescriptionGopNumBFrames = var.videodescription_gop_numb_frames
    VideoDescriptionGopSize = var.videodescription_gop_size
    VideoDescriptionGopSizeUnits = var.videodescription_gop_size_units
    VideoDescriptionLevel = var.videodescription_level
    VideoDescriptionLookAheadRateControl = var.videodescription_look_ahead_rate_control
    VideoDescriptionNumRefFrames = var.videodescription_num_ref_frames
    VideoDescriptionParDenominator = var.videodescription_par_denominator
    VideoDescriptionParNumerator = var.videodescription_par_numerator
    VideoDescriptionProfile = var.videodescription_profile
    VideoDescriptionRateControlMode = var.videodescription_rate_control_mode
    VideoDescriptionSceneChangeDetect = var.videodescription_scene_change_detect
    VideoDescriptionSlices = var.videodescription_slices
    VideoDescriptionSpatialAq = var.videodescription_spatial_aq
    VideoDescriptionSyntax = var.videodescription_syntax
    VideoDescriptionTemporalAq = var.videodescription_temporal_aq
    VideoDescriptionTimecodeInsertion = var.videodescription_timecode_insertion
    VideoDescriptionHeight = var.videodescription_height
    VideoDescriptionWidth = var.videodescription_width
    MediaLiveArchiveOutputGroupName = var.medialive_archive_output_group_name
    MediaLiveArchiveOutputName = var.medialive_archive_output_name
    MediaLiveArchiveDestinationId = var.medialive_archive_destination_id
    MediaLiveArchiveDestinationURL = "s3ssl://${var.elemental_archive_input_bucket}/latest/"
    M2tsAbsentInputAudioBehavior = var.m2ts_absent_input_audiobehavior
    M2tsArib = var.m2ts_arib
    M2tsAribCaptionsPid = var.m2ts_arib_captions_pid
    M2tsAribCaptionsPidControl = var.m2ts_arib_captions_pid_control
    M2tsAudioBufferModel = var.m2ts_audio_buffer_model
    M2tsAudioFramesPerPes = var.m2ts_audio_frames_per_pes
    M2tsAudioPids = var.m2ts_audio_pids
    M2tsAudioStreamType = var.m2ts_audio_stream_type
    M2tsBufferModel = var.m2ts_buffer_model
    M2tsCcDescriptor = var.m2ts_cc_descriptor
    M2tsDvbSubPids = var.m2ts_dvb_sub_pids
    M2tsDvbTeletextPid = var.m2ts_dvb_teletext_pid
    M2tsEbif = var.m2ts_ebif
    M2tsEbpAudioInterval = var.m2ts_ebp_audio_interval
    M2tsEbpPlacement = var.m2ts_ebp_placement
    M2tsEsRateInPes = var.m2ts_es_rate_in_pes
    M2tsEtvPlatformPid = var.m2ts_etv_platform_pid
    M2tsEtvSignalPid = var.m2ts_etv_signal_pid
    M2tsKlv = var.m2ts_klv
    M2tsKlvDataPids = var.m2ts_klv_data_pids
    M2tsNielsenId3Behavior = var.m2ts_nielsen_id3_behavior
    M2tsPatInterval = var.m2ts_pat_interval
    M2tsPcrControl = var.m2ts_pcr_control
    M2tsPcrPeriod = var.m2ts_pcr_period
    M2tsPmtInterval = var.m2ts_pmt_interval
    M2tsPmtPid = var.m2ts_pmt_pid
    M2tsRateMode = var.m2ts_rate_mode
    M2tsScte27Pids = var.m2ts_scte27_pids
    M2tsScte35Control = var.m2ts_scte35_control
    M2tsScte35Pid = var.m2ts_scte35_pid
    M2tsSegmentationMarkers = var.m2ts_segmentation_markers
    M2tsSegmentationStyle = var.m2ts_segmentation_style
    M2tsTimedMetadataBehavior = var.m2ts_timed_metadata_behavior
    M2tsTimedMetadataPid = var.m2ts_timed_metadata_pid
    M2tsVideoPid = var.m2ts_video_pid
    # Variables related to Audio Description
    AudioDescriptionsAudioSelectorName = var.audiodescriptions_audio_selector_name
    AudioDescriptionsAudioTypeControl = var.audiodescriptions_audio_type_control
    AudioDescriptionsLanguageCodeControl = var.audiodescriptions_language_code_control
    AudioDescriptionsName = var.audiodescriptions_name
    AacSettingsBitrate = var.aacsettings_bitrate
    AacSettingsCodingMode = var.aacsettings_coding_mode
    AacSettingsInputType = var.aacsettings_input_type
    AacSettingsProfile = var.aacsettings_profile
    AacSettingsRateControlMode = var.aacsettings_rate_control_mode
    AacSettingsRawFormat = var.aacsettings_raw_format
    AacSettingsSampleRate = var.aacsettings_sample_rate
    AacSettingsSpec = var.aacsettings_spec
    #MediaLiveStreamName = var.medialive_stream_name
  }

  template_url = "https://${var.apes_backend_bucket}.s3.${data.aws_region.current.name}.amazonaws.com/cf-templates/medialive.yaml"
  tags = merge(
    var.tags,
    tomap({ "Name" = var.medialive-stack_name })
  )
}
