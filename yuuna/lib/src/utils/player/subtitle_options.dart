import 'package:hive/hive.dart';
import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

/// Settings that are persisted for the blur widget used in the player.
@JsonSerializable()
@Collection()
class SubtitleOptions {
  /// Initialise this object.
  SubtitleOptions({
    required this.preferences,
    required this.subtitleDelay,
    required this.fontSize,
    required this.fontName,
    required this.subtitleBackgroundOpacity,
    required this.regexFilter,
    required this.subtitleOutlineWidth,
    required this.subtitleBackgroundBlurRadius,
    required this.alwaysAboveBottomBar,
  });

  /// Used for getting "global" preferences.
  final Box preferences;

  /// Audio allowance, used for audio export, in milliseconds.
  int get audioAllowance {
    return _audioAllowance ?? 
        preferences.get('audio_allowance', defaultValue: 0);
  }

  /// Audio allowance, used for audio export, in milliseconds.
  set audioAllowance(int? audioAllowance) {
    _audioAllowance = audioAllowance;
  }
  
  /// Audio allowance, used for audio export, in milliseconds.
  int? _audioAllowance;

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