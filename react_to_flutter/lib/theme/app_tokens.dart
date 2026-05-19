import 'package:flutter/material.dart';

class AppTokens {
  const AppTokens({
    required this.name,
    required this.fontFamilySans,
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.streak,
    required this.streakDark,
    required this.backgroundPage,
    required this.backgroundSurface,
    required this.borderNeutralSubtle,
    required this.actionSuccess,
    required this.actionSuccessLight,
    required this.actionError,
    required this.actionErrorLight,
    required this.radiusContainerLarge,
    required this.radiusXl,
    required this.radius2xl,
    required this.radius3xl,
    required this.shadowPrimaryLgOffset,
    required this.shadowPrimarySmOffset,
    required this.shadowSecondaryOffset,
    required this.shadowGhostOffset,
    required this.shadowFeedbackOffset,
    required this.shadowStreakOffset,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.softGray,
    required this.indigoSoft,
    required this.greenSoft,
    required this.redSoft,
    required this.orangeSoft,
    required this.borderWidthDefault,
    required this.spacePanelPadding,
    required this.spacePanelGapLg,
    required this.spacePanelGapMd,
    required this.spacePanelGapSm,
    required this.spaceControlGapMd,
    required this.sizePanelMinHeightMd,
    required this.fontSizeTextEyebrow,
    required this.fontSizeTextBody,
    required this.fontSizeTextMuted,
    required this.fontSizeTextTitle,
    required this.fontSizeTextDisplay,
    required this.fontSizeFieldDisplay,
    required this.fontSizeTactileSm,
    required this.fontSizeTactileMd,
    required this.fontSizeTactileLg,
    required this.fontSizeTactileIcon,
    required this.fontWeightTextBase,
    required this.fontWeightTextBody,
    required this.fontWeightTextStrong,
    required this.fontWeightTextHeavy,
    required this.lineHeightTextBody,
    required this.lineHeightTextTitle,
    required this.lineHeightTextDisplay,
    required this.lineHeightFieldDisplay,
    required this.lineHeightTactile,
    required this.letterSpacingTextEyebrow,
    required this.sizeIconMd,
    required this.sizeIconLg,
    required this.colorTransparent,
    required this.colorTextOnBrand,
  });

  final String name;
  final String fontFamilySans;
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;
  final Color streak;
  final Color streakDark;
  final Color backgroundPage;
  final Color backgroundSurface;
  final Color borderNeutralSubtle;
  final Color actionSuccess;
  final Color actionSuccessLight;
  final Color actionError;
  final Color actionErrorLight;
  final double radiusContainerLarge;
  final double radiusXl;
  final double radius2xl;
  final double radius3xl;
  final double shadowPrimaryLgOffset;
  final double shadowPrimarySmOffset;
  final double shadowSecondaryOffset;
  final double shadowGhostOffset;
  final double shadowFeedbackOffset;
  final double shadowStreakOffset;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color softGray;
  final Color indigoSoft;
  final Color greenSoft;
  final Color redSoft;
  final Color orangeSoft;
  final double borderWidthDefault;
  final double spacePanelPadding;
  final double spacePanelGapLg;
  final double spacePanelGapMd;
  final double spacePanelGapSm;
  final double spaceControlGapMd;
  final double sizePanelMinHeightMd;
  final double fontSizeTextEyebrow;
  final double fontSizeTextBody;
  final double fontSizeTextMuted;
  final double fontSizeTextTitle;
  final double fontSizeTextDisplay;
  final double fontSizeFieldDisplay;
  final double fontSizeTactileSm;
  final double fontSizeTactileMd;
  final double fontSizeTactileLg;
  final double fontSizeTactileIcon;
  final FontWeight fontWeightTextBase;
  final FontWeight fontWeightTextBody;
  final FontWeight fontWeightTextStrong;
  final FontWeight fontWeightTextHeavy;
  final double lineHeightTextBody;
  final double lineHeightTextTitle;
  final double lineHeightTextDisplay;
  final double lineHeightFieldDisplay;
  final double lineHeightTactile;
  final double letterSpacingTextEyebrow;
  final double sizeIconMd;
  final double sizeIconLg;
  final Color colorTransparent;
  final Color colorTextOnBrand;
}

const AppTokens defaultLight = AppTokens(
  name: 'BooMondai Light',
  fontFamilySans: 'Noto Sans',
  primary: Color(0xff6366f1),
  primaryDark: Color(0xff3f498a),
  primaryLight: Color(0xffc7d2fe),
  streak: Color(0xfff97316),
  streakDark: Color(0xffc2410c),
  backgroundPage: Color(0xfff8f9fa),
  backgroundSurface: Color(0xffffffff),
  borderNeutralSubtle: Color(0xffe5e7eb),
  actionSuccess: Color(0xff22c55e),
  actionSuccessLight: Color(0xffbbf7d0),
  actionError: Color(0xffef4444),
  actionErrorLight: Color(0xfffecaca),
  radiusContainerLarge: 40,
  radiusXl: 12,
  radius2xl: 16,
  radius3xl: 24,
  shadowPrimaryLgOffset: 6,
  shadowPrimarySmOffset: 4,
  shadowSecondaryOffset: 6,
  shadowGhostOffset: 4,
  shadowFeedbackOffset: 4,
  shadowStreakOffset: 6,
  textPrimary: Color(0xff111827),
  textSecondary: Color(0xff6b7280),
  textMuted: Color(0xff9ca3af),
  softGray: Color(0xfff3f4f6),
  indigoSoft: Color(0xffeef2ff),
  greenSoft: Color(0xfff0fdf4),
  redSoft: Color(0xfffef2f2),
  orangeSoft: Color(0xfffff7ed),
  borderWidthDefault: 2,
  spacePanelPadding: 28,
  spacePanelGapLg: 24,
  spacePanelGapMd: 18,
  spacePanelGapSm: 12,
  spaceControlGapMd: 10,
  sizePanelMinHeightMd: 350,
  fontSizeTextEyebrow: 10,
  fontSizeTextBody: 14,
  fontSizeTextMuted: 12,
  fontSizeTextTitle: 22,
  fontSizeTextDisplay: 36,
  fontSizeFieldDisplay: 30,
  fontSizeTactileSm: 14,
  fontSizeTactileMd: 16,
  fontSizeTactileLg: 18,
  fontSizeTactileIcon: 0,
  fontWeightTextBase: FontWeight.w700,
  fontWeightTextBody: FontWeight.w600,
  fontWeightTextStrong: FontWeight.w800,
  fontWeightTextHeavy: FontWeight.w900,
  lineHeightTextBody: 1.45,
  lineHeightTextTitle: 1.1,
  lineHeightTextDisplay: 1.05,
  lineHeightFieldDisplay: 1.15,
  lineHeightTactile: 1.1,
  letterSpacingTextEyebrow: 1.6,
  sizeIconMd: 18,
  sizeIconLg: 22,
  colorTransparent: Colors.transparent,
  colorTextOnBrand: Colors.white,
);

const AppTokens defaultDark = AppTokens(
  name: 'BooMondai Dark',
  fontFamilySans: 'Noto Sans',
  primary: Color(0xff818cf8),
  primaryDark: Color(0xff4f46e5),
  primaryLight: Color(0xff3730a3),
  streak: Color(0xfffb923c),
  streakDark: Color(0xffea580c),
  backgroundPage: Color(0xff0b1020),
  backgroundSurface: Color(0xff111827),
  borderNeutralSubtle: Color(0xff374151),
  actionSuccess: Color(0xff4ade80),
  actionSuccessLight: Color(0xff14532d),
  actionError: Color(0xfff87171),
  actionErrorLight: Color(0xff7f1d1d),
  radiusContainerLarge: 40,
  radiusXl: 12,
  radius2xl: 16,
  radius3xl: 24,
  shadowPrimaryLgOffset: 6,
  shadowPrimarySmOffset: 4,
  shadowSecondaryOffset: 6,
  shadowGhostOffset: 4,
  shadowFeedbackOffset: 4,
  shadowStreakOffset: 6,
  textPrimary: Color(0xfff3f4f6),
  textSecondary: Color(0xffd1d5db),
  textMuted: Color(0xff9ca3af),
  softGray: Color(0xff1f2937),
  indigoSoft: Color(0xff312e81),
  greenSoft: Color(0xff052e16),
  redSoft: Color(0xff450a0a),
  orangeSoft: Color(0xff431407),
  borderWidthDefault: 2,
  spacePanelPadding: 28,
  spacePanelGapLg: 24,
  spacePanelGapMd: 18,
  spacePanelGapSm: 12,
  spaceControlGapMd: 10,
  sizePanelMinHeightMd: 350,
  fontSizeTextEyebrow: 10,
  fontSizeTextBody: 14,
  fontSizeTextMuted: 12,
  fontSizeTextTitle: 22,
  fontSizeTextDisplay: 36,
  fontSizeFieldDisplay: 30,
  fontSizeTactileSm: 14,
  fontSizeTactileMd: 16,
  fontSizeTactileLg: 18,
  fontSizeTactileIcon: 0,
  fontWeightTextBase: FontWeight.w700,
  fontWeightTextBody: FontWeight.w600,
  fontWeightTextStrong: FontWeight.w800,
  fontWeightTextHeavy: FontWeight.w900,
  lineHeightTextBody: 1.45,
  lineHeightTextTitle: 1.1,
  lineHeightTextDisplay: 1.05,
  lineHeightFieldDisplay: 1.15,
  lineHeightTactile: 1.1,
  letterSpacingTextEyebrow: 1.6,
  sizeIconMd: 18,
  sizeIconLg: 22,
  colorTransparent: Colors.transparent,
  colorTextOnBrand: Colors.white,
);
