import 'package:react_to_flutter/theme/app_tokens.dart';
import 'package:theme_variants/theme_variants.dart';

enum AppTextRole { eyebrow, body, title, display, muted }

final appTextStyle = VariantStyle.textParts<AppTokens>(
  base: (tokens) => {
    TextStylePart.color(tokens.textPrimary),
    TextStylePart.fontWeight(tokens.fontWeightTextBase),
  },
  defaultVariants: const [AppTextRole.body],
  variants: {
    AppTextRole.eyebrow: (tokens) => {
      TextStylePart.color(tokens.textMuted),
      TextStylePart.fontSize(tokens.fontSizeTextEyebrow),
      TextStylePart.fontWeight(tokens.fontWeightTextHeavy),
      (style) => style.copyWith(letterSpacing: tokens.letterSpacingTextEyebrow),
    },
    AppTextRole.body: (tokens) => {
      TextStylePart.color(tokens.textSecondary),
      TextStylePart.fontSize(tokens.fontSizeTextBody),
      TextStylePart.fontWeight(tokens.fontWeightTextBody),
      TextStylePart.height(tokens.lineHeightTextBody),
    },
    AppTextRole.title: (tokens) => {
      TextStylePart.color(tokens.textPrimary),
      TextStylePart.fontSize(tokens.fontSizeTextTitle),
      TextStylePart.fontWeight(tokens.fontWeightTextHeavy),
      TextStylePart.height(tokens.lineHeightTextTitle),
    },
    AppTextRole.display: (tokens) => {
      TextStylePart.color(tokens.textPrimary),
      TextStylePart.fontSize(tokens.fontSizeTextDisplay),
      TextStylePart.fontWeight(tokens.fontWeightTextHeavy),
      TextStylePart.height(tokens.lineHeightTextDisplay),
    },
    AppTextRole.muted: (tokens) => {
      TextStylePart.color(tokens.textMuted),
      TextStylePart.fontSize(tokens.fontSizeTextMuted),
      TextStylePart.fontWeight(tokens.fontWeightTextStrong),
    },
  },
);
