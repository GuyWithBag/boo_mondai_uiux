import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:react_to_flutter/theme/app_tokens.dart';
import 'package:theme_variants/theme_variants.dart';

enum TextSize { header, labelLarge, label, labelSmall, bodyLarge }

enum TextWeight { base, body, strong, heavy }

enum TextTone { primary, secondary, muted }

final appTextStyle = VariantStyle.textParts<AppTokens>(
  base: (tokens) => {
    TextStylePart.color(tokens.textPrimary),
    TextStylePart.fontWeight(tokens.fontWeightTextBase),
  },
  defaultVariants: const [
    TextSize.labelSmall,
    TextWeight.body,
    TextTone.secondary,
  ],
  variants: {
    TextSize.header: (tokens) => {
      TextStylePart.fontSize(tokens.textSizeHeader.sp),
      TextStylePart.height(tokens.lineHeightTextDisplay),
    },
    TextSize.labelLarge: (tokens) => {
      TextStylePart.fontSize(tokens.textSizeLabelLarge.sp),
      TextStylePart.height(tokens.lineHeightTextTitle),
    },
    TextSize.label: (tokens) => {
      TextStylePart.fontSize(tokens.textSizeLabel.sp),
      TextStylePart.height(tokens.lineHeightTextBody),
    },
    TextSize.labelSmall: (tokens) => {
      TextStylePart.fontSize(tokens.textSizeLabelSmall.sp),
      (style) => style.copyWith(letterSpacing: tokens.letterSpacingTextEyebrow),
    },
    TextSize.bodyLarge: (tokens) => {
      TextStylePart.fontSize(tokens.textSizeBodyLarge.sp),
      TextStylePart.height(tokens.lineHeightFieldDisplay),
    },
    TextWeight.base: (tokens) => {
      TextStylePart.fontWeight(tokens.fontWeightTextBase),
    },
    TextWeight.body: (tokens) => {
      TextStylePart.fontWeight(tokens.fontWeightTextBody),
    },
    TextWeight.strong: (tokens) => {
      TextStylePart.fontWeight(tokens.fontWeightTextStrong),
    },
    TextWeight.heavy: (tokens) => {
      TextStylePart.fontWeight(tokens.fontWeightTextHeavy),
    },
    TextTone.primary: (tokens) => {TextStylePart.color(tokens.textPrimary)},
    TextTone.secondary: (tokens) => {TextStylePart.color(tokens.textSecondary)},
    TextTone.muted: (tokens) => {TextStylePart.color(tokens.textMuted)},
  },
);
