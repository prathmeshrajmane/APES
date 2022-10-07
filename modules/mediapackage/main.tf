resource "aws_cloudformation_stack" "mediapackage_channel"{
  name = var.mediapackage-stack_name
#  data "aws_region" "current" {}
  parameters = {
    MediaPackageChannelId = var.mediapackage_channel_id
    MediaPackageHlsManifestName = var.mediapackage_hls_manifest_name
    MediaPackageManifestId = var.mediapackage_manifest_id
    MediaPackageSegmentDurationSeconds = var.mediapackage_segment_duration_seconds
    MediaPackageMaxVideoBitsPerSecond = var.mediapackage_maxvideo_bitspersecond
    MediaPackageMinVideoBitsPerSecond = var.mediapackage_minvideo_bitspersecond
    MediaPackageStreamOrder = var.mediapackage_stream_order
    MediaPackageOriginId = var.mediapackage_origin_id
    MediaPackageManifestName = var.mediapackage_manifestname
    MediaPackageOrigination = var.mediapackage_origination
    MediaPackageStartoverWindowSeconds = var.mediapackage_startover_windowseconds
    MediaPackageTimeDelaySeconds = var.mediapackage_time_delay_seconds
    MediaPackageAdTriggerSpliceInsert = var.mediapackage_ad_trigger_splice_insert
    MediaPackageAdTriggerProviderAdvertisement = var.mediapackage_ad_trigger_provider_advertisement
    MediaPackageAdTriggerDistributorAdvertisement = var.mediapackage_ad_trigger_distributor_advertisement
    MediaPackageAdTriggerProviderPlacementOpportunity = var.mediapackage_ad_trigger_provider_placement_opportunity
    MediaPackageAdTriggerDistributorPlacementOpportunity = var.mediapackage_ad_trigger_distributor_placement_opportunity
    MediaPackageIncludeIframeOnlyStream = var.mediapackage_include_iframe_only_stream
    # Variables for Origin endpoint with Dash Package type
    MediaPackageDashManifestLayout = var.mediapackage_dash_manifest_layout
    MediaPackageDashManifestWindowSeconds = var.mediapackage_dash_manifest_window_seconds
    MediaPackageDashMinBufferTimeSeconds = var.mediapackage_dash_min_buffer_time_seconds
    MediaPackageDashMinUpdatePeriodSeconds = var.mediapackage_dash_min_update_period_seconds
    MediaPackageDashSegmentDurationSeconds = var.mediapackage_dash_segment_duration_seconds
    MediaPackageDashSegmentTemplateFormat = var.mediapackage_dash_segment_template_format
    MediaPackageDashSuggestedPresentationDelaySeconds = var.mediapackage_dash_suggested_presentation_delay_seconds
    MediaPackageDashOriginId = var.mediapackage_dash_origin_id
    # Variables for Origin endpoint with Hls Package type
    MediaPackageHlsPlaylistWindowSeconds = var.mediapackage_hls_playlist_window_seconds
    MediaPackageHlsProgramDateTimeIntervalSeconds = var.mediapackage_hls_program_date_time_interval_seconds
    MediaPackageHlsSegmentDurationSeconds = var.mediapackage_hls_segment_duration_seconds
    MediaPackageHlsOriginId = var.mediapackage_hls_origin_id
    MediaPackageHlsUseAudioRenditionGroup = var.mediapackage_hls_use_audio_rendition_group
  }

  template_url = "https://${var.apes_backend_bucket}.s3.${data.aws_region.current.name}.amazonaws.com/cf-templates/mediapackage.yaml"
  tags = merge(
    var.tags,
    tomap({ "Name" = var.mediapackage-stack_name })
  )
}


