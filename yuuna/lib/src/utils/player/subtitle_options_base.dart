abstract class SubtitleOptionsBase {
  /// Initialise this object.
  SubtitleOptionsBase({
    this.audioAllowance,
    this.subtitleDelay,
    this.fontSize,
    this.fontName,
    this.subtitleBackgroundOpacity,
    this.regexFilter,
    this.subtitleOutlineWidth,
    this.subtitleBackgroundBlurRadius,
    this.alwaysAboveBottomBar,
  });

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
