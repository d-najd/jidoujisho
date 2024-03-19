import 'package:yuuna/src/utils/player/subtitle_options_base.dart';

/// Settings that are persisted for the blur widget used in the player.
/// 
class SubtitleOptions extends SubtitleOptionsBase {
  /// Initialise this object.

  /*
  PlayerMediaSource({
    required super.uniqueKey,
    required super.sourceName,
    required super.description,
    required super.icon,
    required super.implementsSearch,
    required super.implementsHistory,
  }) : super(
    mediaType: PlayerMediaType.instance,
    overridesAutoAudio: true,
    overridesAutoImage: true,
  );
   */
  
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
  }) : super(
    audioAllowance: audioAllowance,
    
  )
  
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
