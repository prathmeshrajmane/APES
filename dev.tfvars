# Variables used in module vpc
vpc-name              = "apes-dev-vpc"
vpc-cidr              = "10.0.8.0/24"
public-cidr           = "0.0.0.0/0"
instanceTenancy       = "default"
dnsSupport            = true
dnsHostNames          = true
public-subnet-name    = "apes-dev-public-subnet"
private-subnet-name   = "apes-dev-private-subnet"
public-subnets-cidr   =["10.0.8.192/26"]
private-subnets-cidr  =["10.0.8.128/27","10.0.8.96/27"]
internet-gateway-name = "apes-dev-internet-gateway"
nat-gateway-name      = "apes-dev-nat-gateway"
natConnectivity       = "private"
public-rt-name        = "apes-dev-public-routetable"
private-rt-name       = "apes-dev-private-routetable"
apes-sg-name          = "apes-dev-sg"

# Variables used in module iam-roles
apes_medialive_role         = "apes-ElementalLive"
s3_iam_policy               = "apes-S3Access"
mediapackage_iam_policy     = "apes-ElementalMediaPackageAccess"
medialive_iam_policy        = "apes-ElementalMediaLiveAccess"

# Variables used for s3
elemental_vod_input_bucket       = "apes-dev-media-input-vod"
elemental_archive_input_bucket = "apes-dev-media-input-archive"
elemental_output_bucket       = "apes-dev-media-output"
apes_backend_bucket = "apes-dev-backend"
apes_ui_bucket = "apes-dev-frontend"
apes_s3_origin_id            = "apes-S3Origin"
apes_s3_output_origin_id = "apes-s3-output-origin"

# Variables used in module medialive
mediapackage_destination_id = "destination1"
mediapackage_channel_id     = "apes"
medialive_input_codec = "AVC"
medialive_input_maximum_bitrate = "MAX_20_MBPS"
medialive_input_resolution = "HD"
tags={
  "Env" = "Dev"
  "Project"                = "APES"
"Project" = "APES"}
medialive_input_sg_cidr = "49.37.0.0/16"
medialive-stack_name = "apes-dev-medialive"
medialive_input_name = "input1"
input_destination_a = "desta"
input_destination_b = "destb"
medialive_channel_name = "apes-dev"
medialive_outputgroup_name = "output_group_a"
medialive_outputgroup_destination_id = "op_dest_a"
medialive_output_name = "Output_1"
videodescription_name = "VD_name"
videodescription_par_control = "SPECIFIED"
videodescription_framerate_denominator = 1
videodescription_framerate_numerator = 30
videodescription_framerate_control = "SPECIFIED"
videodescription_adaptive_quantization = "HIGH"
videodescription_afd_signaling = "NONE"
videodescription_bitrate = 1500000
videodescription_color_metadata = "INSERT"
videodescription_entropy_encoding = "CABAC"
videodescription_flicker_aq = "ENABLED"
videodescription_gop_b_reference = "ENABLED"
videodescription_gop_closed_cadence = 1
videodescription_gop_numb_frames = 6
videodescription_gop_size = 60
videodescription_gop_size_units = "FRAMES"
videodescription_level = "H264_LEVEL_AUTO"
videodescription_look_ahead_rate_control = "HIGH"
videodescription_num_ref_frames = 3
videodescription_par_denominator = 3
videodescription_par_numerator = 4
videodescription_profile = "MAIN"
videodescription_rate_control_mode = "CBR"
videodescription_scene_change_detect = "ENABLED"
videodescription_slices = 1
videodescription_spatial_aq = "ENABLED"
videodescription_syntax = "DEFAULT"
videodescription_temporal_aq = "ENABLED"
videodescription_timecode_insertion = "DISABLED"
videodescription_height = 1080
videodescription_width = 1920
medialive_archive_output_group_name = "ArchiveOPGroup"
medialive_archive_output_name = "op_archive_dest"
medialive_archive_destination_id = "apes-archive-dest"
m2ts_absent_input_audiobehavior = "ENCODE_SILENCE"
m2ts_arib = "DISABLED"
m2ts_arib_captions_pid = "507"
m2ts_arib_captions_pid_control = "AUTO"
m2ts_audio_buffer_model = "ATSC"
m2ts_audio_frames_per_pes = 2
m2ts_audio_pids = "482-498"
m2ts_audio_stream_type = "DVB"
m2ts_buffer_model = "MULTIPLEX"
m2ts_cc_descriptor = "DISABLED"
m2ts_dvb_sub_pids = "460-479"
m2ts_dvb_teletext_pid = "499"
m2ts_ebif = "NONE"
m2ts_ebp_audio_interval = "VIDEO_INTERVAL"
m2ts_ebp_placement = "VIDEO_AND_AUDIO_PIDS"
m2ts_es_rate_in_pes = "EXCLUDE"
m2ts_etv_platform_pid = "504"
m2ts_etv_signal_pid = "505"
m2ts_klv = "NONE"
m2ts_klv_data_pids = "501"
m2ts_nielsen_id3_behavior = "NO_PASSTHROUGH"
m2ts_pat_interval = 100
m2ts_pcr_control = "PCR_EVERY_PES_PACKET"
m2ts_pcr_period = 40
m2ts_pmt_interval = 100
m2ts_pmt_pid = "480"
m2ts_rate_mode = "CBR"
m2ts_scte27_pids = "450-459"
m2ts_scte35_control = "NONE"
m2ts_scte35_pid = "500"
m2ts_segmentation_markers = "NONE"
m2ts_segmentation_style = "MAINTAIN_CADENCE"
m2ts_timed_metadata_behavior = "NO_PASSTHROUGH"
m2ts_timed_metadata_pid = "502"
m2ts_video_pid = "481"

# Variables used in module mediapackage
mediapackage-stack_name = "apes-dev-mediapackage-origin"
mediapackage_hls_manifest_name = "index"
mediapackage_manifest_id = "Manifestid"
mediapackage_segment_duration_seconds = 6
mediapackage_maxvideo_bitspersecond = 2147483647
mediapackage_minvideo_bitspersecond = 0
mediapackage_stream_order = "ORIGINAL"
mediapackage_origin_id = "apes-mediapackage-origin"
mediapackage_manifestname = "index"
mediapackage_origination = "ALLOW"
mediapackage_startover_windowseconds = 0
mediapackage_time_delay_seconds = 0

audiodescriptions_audio_selector_name = "Default"
audiodescriptions_audio_type_control = "FOLLOW_INPUT"
audiodescriptions_language_code_control = "FOLLOW_INPUT"
audiodescriptions_name = "audio_1"
aacsettings_bitrate = 128000
aacsettings_coding_mode = "CODING_MODE_2_0"
aacsettings_input_type = "NORMAL"
aacsettings_profile = "LC"
aacsettings_rate_control_mode = "CBR"
aacsettings_raw_format = "NONE"
aacsettings_sample_rate = 48000
aacsettings_spec = "MPEG4"
mediapackage_ad_trigger_splice_insert = "SPLICE_INSERT"
mediapackage_ad_trigger_provider_advertisement = "PROVIDER_ADVERTISEMENT"
mediapackage_ad_trigger_distributor_advertisement = "DISTRIBUTOR_ADVERTISEMENT"
mediapackage_ad_trigger_provider_placement_opportunity = "PROVIDER_PLACEMENT_OPPORTUNITY"
mediapackage_ad_trigger_distributor_placement_opportunity = "DISTRIBUTOR_PLACEMENT_OPPORTUNITY"
mediapackage_include_iframe_only_strea = "False"
mediapackage_dash_manifest_layout = "FULL"
mediapackage_dash_manifest_window_seconds = 60
mediapackage_dash_min_buffer_time_seconds = 30
mediapackage_dash_min_update_period_seconds = 15
mediapackage_dash_segment_duration_seconds = 2
mediapackage_dash_segment_template_format = "NUMBER_WITH_TIMELINE"
mediapackage_dash_suggested_presentation_delay_seconds = 25
mediapackage_dash_origin_id = "MediaPackageOrigin-Dash"
mediapackage_hls_playlist_window_seconds = 60
mediapackage_hls_program_date_time_interval_seconds = 0
mediapackage_hls_segment_duration_seconds = 6
mediapackage_hls_origin_id = "MediaPackage-HLS"
mediapackage_hls_use_audio_rendition_group = "False"
mediapackage_include_iframe_only_stream = "False"

########

apes_vod_lambdafunction_role  = "apes-vod-mediaconvert-lambda-role"
#apes_archive_lambdafunction_role  = "apes-archive-mediaconvert-lambda-role"

vod_mediaconvert_iam_policy   = "apes-vod-ElementalMediaConvertAccess"
#archive_mediaconvert_iam_policy   = "apes-archive-ElementalMediaConvertAccess"

apes_vod_lambdafunction  = "mediaconvert"
apes_archive_lambdafunction = "archive"
apes_lambdahandler_name   = "handler"
apes_lambdaruntime        = "python3.8"
apes_lambdatimeout        = "900"
apes_archive_lambda       = "apes_archive_lambda"


#Live streaming - https://d3vx8ytsafqq87.cloudfront.net/out/v1/085112e90a644c939ca86cb740d30236/index.m3u8
#Vod streaming - https://d1qhrviiskrib9.cloudfront.net/archive/assets/HLS/stream_09-23-2022, 06:42:25/.000000.m3u8

#https://82934cf9c8696bd2.mediapackage.us-east-1.amazonaws.com/out/v1/81814ca40135469599c5147d56270b23/index.m3u8