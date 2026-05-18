import 'package:flutter/material.dart';

class AppTokens {
  const AppTokens.light() : name = 'BooMondai Light', isDark = false;

  const AppTokens.dark() : name = 'BooMondai Dark', isDark = true;

  final String name;
  final bool isDark;

  String get fontFamilySans => 'Noto Sans';

  Color get primary =>
      isDark ? const Color(0xff818cf8) : const Color(0xff6366f1);
  Color get primaryDark =>
      isDark ? const Color(0xff4f46e5) : const Color(0xff3f498a);
  Color get primaryLight =>
      isDark ? const Color(0xff3730a3) : const Color(0xffc7d2fe);
  Color get streak =>
      isDark ? const Color(0xfffb923c) : const Color(0xfff97316);
  Color get streakDark =>
      isDark ? const Color(0xffea580c) : const Color(0xffc2410c);

  Color get backgroundPage =>
      isDark ? const Color(0xff0b1020) : const Color(0xfff8f9fa);
  Color get backgroundSurface =>
      isDark ? const Color(0xff111827) : const Color(0xffffffff);
  Color get borderNeutralSubtle =>
      isDark ? const Color(0xff374151) : const Color(0xffe5e7eb);

  Color get actionSuccess =>
      isDark ? const Color(0xff4ade80) : const Color(0xff22c55e);
  Color get actionSuccessLight =>
      isDark ? const Color(0xff14532d) : const Color(0xffbbf7d0);
  Color get actionError =>
      isDark ? const Color(0xfff87171) : const Color(0xffef4444);
  Color get actionErrorLight =>
      isDark ? const Color(0xff7f1d1d) : const Color(0xfffecaca);

  double get radiusContainerLarge => 40;
  double get radiusXl => 12;
  double get radius2xl => 16;
  double get radius3xl => 24;

  double get shadowPrimaryLgOffset => 6;
  double get shadowPrimarySmOffset => 4;
  double get shadowSecondaryOffset => 6;
  double get shadowGhostOffset => 4;
  double get shadowFeedbackOffset => 4;
  double get shadowStreakOffset => 6;

  Color get textPrimary =>
      isDark ? const Color(0xfff3f4f6) : const Color(0xff111827);
  Color get textSecondary =>
      isDark ? const Color(0xffd1d5db) : const Color(0xff6b7280);
  Color get textMuted => const Color(0xff9ca3af);
  Color get softGray =>
      isDark ? const Color(0xff1f2937) : const Color(0xfff3f4f6);
  Color get indigoSoft =>
      isDark ? const Color(0xff312e81) : const Color(0xffeef2ff);
  Color get greenSoft =>
      isDark ? const Color(0xff052e16) : const Color(0xfff0fdf4);
  Color get redSoft =>
      isDark ? const Color(0xff450a0a) : const Color(0xfffef2f2);
  Color get orangeSoft =>
      isDark ? const Color(0xff431407) : const Color(0xfffff7ed);
}
