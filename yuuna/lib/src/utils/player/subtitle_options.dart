import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:yuuna/models.dart';

/// Settings that are persisted for the blur widget used in the player.
@JsonSerializable()
@Collection()
class SubtitleOptions {
  /// Initialise this object.
  SubtitleOptions({
    required this.appModel,
  });

  /// Needed for getting "global" subtitle preferences
  final AppModel appModel;

  /// Audio allowance, used for audio export, in milliseconds.
  int get audioAllowance {
    return _audioAllowance ?? 
        appModel.preferences.get('audio_allowance', defaultValue: 0);
  }

  set audioAllowance(int? audioAllowance) {
    _audioAllowance = audioAllowance;
  }
  
  int? _audioAllowance;

  /// Subtitle delay in milliseconds.
  int get subtitleDelay {
    return _subtitleDelay ??
        appModel.preferences.get('subtitle_delay', defaultValue: 0);
  }
  
  set subtitleDelay(int? subtitleDelay) {
    _subtitleDelay = subtitleDelay;
  }
  
  int? _subtitleDelay;

  /// Subtitle font size.
  double get fontSize {
    return _fontSize ?? 
        appModel.preferences.get('font_size', defaultValue: 20.0);
  }
  
  set fontSize(double? fontSize) {
    _fontSize = fontSize;
  }

  double? _fontSize;

  /// Name of the font preferred for the subtitle.
  String get fontName {
    return _fontName ??
        appModel.preferences.get(
            'font_name/${appModel.targetLanguage.languageCode}', 
            defaultValue: '');
  }
  
  set fontName(String? fontName) {
    _fontName = fontName;
  }
  
  String? _fontName;

  /// Subtitle background blur radius.
  double get subtitleBackgroundBlurRadius {
    return _subtitleBackgroundBlurRadius ?? 
        appModel.preferences.get(
            'subtitle_background_blur_radius', defaultValue: 0.0);
    }
  
  set subtitleBackgroundBlurRadius(double? subtitleBackgroundBlurRadius) {
    _subtitleBackgroundBlurRadius = subtitleBackgroundBlurRadius;
  }

  double? _subtitleBackgroundBlurRadius;

  /// Subtitle background opacity.
  double get subtitleBackgroundOpacity {
    return _subtitleBackgroundOpacity ??
      appModel.preferences.get('subtitle_background_opacity', defaultValue: 0.0);
  }
  
  set subtitleBackgroundOpacity(double? subtitleBackgroundOpacity) {
    _subtitleBackgroundOpacity = subtitleBackgroundOpacity;
  }
  
  double? _subtitleBackgroundOpacity;

  /// Subtitle outline width.
  double get subtitleOutlineWidth {
    return _subtitleOutlineWidth ??
      appModel.preferences.get('subtitle_outline_width', defaultValue: 3.0);
  }
  
  set subtitleOutlineWidth(double? subtitleOutlineWidth) {
    _subtitleOutlineWidth = subtitleOutlineWidth;
  }
  
  double? _subtitleOutlineWidth;

  /// Regex filter used for the subtitle.
  String get regexFilter {
    return _regexFilter ??
      appModel.preferences.get('regex_filter', defaultValue: '');
  }
  
  set regexFilter(String? regexFilter) {
    _regexFilter = regexFilter;
  }

  String? _regexFilter;

  /// Whether or not the subtitle should always be above the bottom bar.
  bool get alwaysAboveBottomBar {
    return _alwaysAboveBottomBar ??
      appModel.preferences.get('subtitle_above_bar', defaultValue: false);
  }
  
  set alwaysAboveBottomBar(bool? alwaysAboveBottomBar) {
    _alwaysAboveBottomBar = alwaysAboveBottomBar;
  }
  
  bool? _alwaysAboveBottomBar;
}
