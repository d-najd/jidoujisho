import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yuuna/pages.dart';

/// Each subtitle has its own setting that can be set and remembered, these 
/// settings differ from the "Global" settings which are set initially when
/// the subtitle is created. These settings also apply to both subtitle files
/// held inside the video file and external subtitles, and are also used to 
/// remember external subtitles that had been selected for the current media.

// TODO needs better name
@JsonSerializable()
@Collection()
class SubtitleOptionsSerializable {
  /*
  MediaItem({
    required this.mediaIdentifier,
    required this.title,
    required this.mediaTypeIdentifier,
    required this.mediaSourceIdentifier,
    required this.position,
    required this.duration,
    required this.canDelete,
    required this.canEdit,
    this.id,
    this.extraUrl,
    this.extra,
    this.base64Image,
    this.imageUrl,
    this.audioUrl,
    this.author,
    this.authorIdentifier,
    this.sourceMetadata,
  });
   */

  /// Location where the external file is stored, also used to determine whether
  /// the subtitle is external or from the video itself.
  String? externalPath;

  /// Index of the subtitle if its from the video file itself.
  int? localIndex;

  /// Audio allowance, used for audio export, in milliseconds.
  int? audioAllowance;

  /// Subtitle delay in milliseconds.
  int? subtitleDelay;

  /// Subtitle font size.
  double? fontSize;

  /// Name of the font preferred for the subtitle.
  String? fontName;

  /// Subtitle background blur radius.
  double? subtitleBackgroundBlurRadius;

  /// Subtitle background opacity.
  double? subtitleBackgroundOpacity;

  /// Subtitle outline width.
  double? subtitleOutlineWidth;

  /// Regex filter used for the subtitle.
  String? regexFilter;

  /// Whether or not the subtitle should always be above the bottom bar.
  bool? alwaysAboveBottomBar;
}

/*
class SubtitleOptions {
  /// Initialise this object.
  SubtitleOptions({
    required this.audioAllowance,
    required this.subtitleDelay,
    required this.fontSize,
    required this.fontName,
    required this.subtitleBackgroundOpacity,
    required this.regexFilter,
    required this.subtitleOutlineWidth,
    required this.subtitleBackgroundBlurRadius,
    required this.alwaysAboveBottomBar,
  });

  /// Audio allowance, used for audio export, in milliseconds.
  int audioAllowance;

  /// Subtitle delay in milliseconds.
  int subtitleDelay;

  /// Subtitle font size.
  double fontSize;

  /// Name of the font preferred for the subtitle.
  String fontName;

  /// Subtitle background blur radius.
  double subtitleBackgroundBlurRadius;

  /// Subtitle background opacity.
  double subtitleBackgroundOpacity;

  /// Subtitle outline width.
  double subtitleOutlineWidth;

  /// Regex filter used for the subtitle.
  String regexFilter;

  /// Whether or not the subtitle should always be above the bottom bar.
  bool alwaysAboveBottomBar;
}
*/
