import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import 'app_tokens.dart';

enum TactileTone { primary, secondary, ghost, success, error, streak, text }

enum TactileSize { sm, md, lg, icon }

enum TactileState { idle, selected, disabled }

enum PanelTone { surface, selected, success, muted, dark }

enum AppTextRole { eyebrow, body, title, display, muted }

final tactileButtonDecoration = VariantStyle.decorationParts<AppTokens>(
  base: (tokens) => {
    DecorationPart.color(tokens.backgroundSurface),
    DecorationPart.borderRadius(BorderRadius.circular(tokens.radius2xl)),
    DecorationPart.border(
      Border.all(color: tokens.borderNeutralSubtle, width: 2),
    ),
    DecorationPart.boxShadow([
      BoxShadow(
        color: tokens.borderNeutralSubtle,
        offset: Offset(0, tokens.shadowSecondaryOffset),
      ),
    ]),
  },
  defaultVariants: const [TactileTone.secondary, TactileState.idle],
  variants: {
    TactileTone.primary: (tokens) => {
      DecorationPart.color(tokens.primary),
      DecorationPart.border(Border.all(color: tokens.primary, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.primaryDark,
          offset: Offset(0, tokens.shadowPrimaryLgOffset),
        ),
      ]),
    },
    TactileTone.secondary: (tokens) => {
      DecorationPart.color(tokens.backgroundSurface),
      DecorationPart.border(
        Border.all(color: tokens.borderNeutralSubtle, width: 2),
      ),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.borderNeutralSubtle,
          offset: Offset(0, tokens.shadowSecondaryOffset),
        ),
      ]),
    },
    TactileTone.ghost: (tokens) => {
      DecorationPart.color(tokens.indigoSoft),
      DecorationPart.border(Border.all(color: tokens.primaryLight, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ]),
    },
    TactileTone.success: (tokens) => {
      DecorationPart.color(tokens.greenSoft),
      DecorationPart.border(Border.all(color: tokens.actionSuccess, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.actionSuccessLight,
          offset: Offset(0, tokens.shadowFeedbackOffset),
        ),
      ]),
    },
    TactileTone.error: (tokens) => {
      DecorationPart.color(tokens.redSoft),
      DecorationPart.border(
        Border.all(color: tokens.actionErrorLight, width: 2),
      ),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.actionErrorLight,
          offset: Offset(0, tokens.shadowFeedbackOffset),
        ),
      ]),
    },
    TactileTone.streak: (tokens) => {
      DecorationPart.color(tokens.streak),
      DecorationPart.border(Border.all(color: tokens.streak, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.streakDark,
          offset: Offset(0, tokens.shadowStreakOffset),
        ),
      ]),
    },
    TactileTone.text: (_) => {
      DecorationPart.color(Colors.transparent),
      DecorationPart.border(Border.all(color: Colors.transparent, width: 0)),
      DecorationPart.boxShadow(const []),
    },
    TactileState.idle: (_) => const <StylePart<BoxDecoration>>{},
    TactileState.selected: (tokens) => {
      DecorationPart.color(tokens.indigoSoft),
      DecorationPart.border(Border.all(color: tokens.primaryLight, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ]),
    },
    TactileState.disabled: (_) => {DecorationPart.boxShadow(const [])},
  },
);

final tactileButtonText = VariantStyle.textParts<AppTokens>(
  base: (tokens) => {
    TextStylePart.color(tokens.textSecondary),
    TextStylePart.fontSize(16),
    TextStylePart.fontWeight(FontWeight.w800),
    TextStylePart.height(1.1),
  },
  defaultVariants: const [TactileTone.secondary, TactileSize.md],
  variants: {
    TactileTone.primary: (_) => {TextStylePart.color(Colors.white)},
    TactileTone.secondary: (tokens) => {
      TextStylePart.color(tokens.textPrimary),
    },
    TactileTone.ghost: (tokens) => {TextStylePart.color(tokens.primary)},
    TactileTone.success: (tokens) => {
      TextStylePart.color(tokens.actionSuccess),
    },
    TactileTone.error: (tokens) => {TextStylePart.color(tokens.actionError)},
    TactileTone.streak: (_) => {TextStylePart.color(Colors.white)},
    TactileTone.text: (tokens) => {TextStylePart.color(tokens.primary)},
    TactileSize.sm: (_) => {TextStylePart.fontSize(14)},
    TactileSize.md: (_) => {TextStylePart.fontSize(16)},
    TactileSize.lg: (_) => {TextStylePart.fontSize(18)},
    TactileSize.icon: (_) => {TextStylePart.fontSize(0)},
  },
);

final panelDecoration = VariantStyle.decorationParts<AppTokens>(
  base: (tokens) => {
    DecorationPart.color(tokens.backgroundSurface),
    DecorationPart.borderRadius(
      BorderRadius.circular(tokens.radiusContainerLarge),
    ),
    DecorationPart.border(
      Border.all(color: tokens.borderNeutralSubtle, width: 2),
    ),
  },
  defaultVariants: const [PanelTone.surface],
  variants: {
    PanelTone.surface: (_) => const <StylePart<BoxDecoration>>{},
    PanelTone.selected: (tokens) => {
      DecorationPart.color(tokens.indigoSoft),
      DecorationPart.border(Border.all(color: tokens.primaryLight, width: 2)),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ]),
    },
    PanelTone.success: (tokens) => {
      DecorationPart.color(tokens.greenSoft),
      DecorationPart.border(Border.all(color: tokens.actionSuccess, width: 2)),
    },
    PanelTone.muted: (tokens) => {
      DecorationPart.color(tokens.softGray),
      DecorationPart.border(
        Border.all(color: tokens.borderNeutralSubtle, width: 2),
      ),
    },
    PanelTone.dark: (_) => {
      DecorationPart.color(const Color(0xff312e81)),
      DecorationPart.radius(40),
    },
  },
);

final appTextStyle = VariantStyle.textParts<AppTokens>(
  base: (tokens) => {
    TextStylePart.color(tokens.textPrimary),
    TextStylePart.fontWeight(FontWeight.w700),
  },
  defaultVariants: const [AppTextRole.body],
  variants: {
    AppTextRole.eyebrow: (tokens) => {
      TextStylePart.color(tokens.textMuted),
      TextStylePart.fontSize(10),
      TextStylePart.fontWeight(FontWeight.w900),
      (style) => style.copyWith(letterSpacing: 1.6),
    },
    AppTextRole.body: (tokens) => {
      TextStylePart.color(tokens.textSecondary),
      TextStylePart.fontSize(14),
      TextStylePart.fontWeight(FontWeight.w600),
      TextStylePart.height(1.45),
    },
    AppTextRole.title: (tokens) => {
      TextStylePart.color(tokens.textPrimary),
      TextStylePart.fontSize(22),
      TextStylePart.fontWeight(FontWeight.w900),
      TextStylePart.height(1.1),
    },
    AppTextRole.display: (tokens) => {
      TextStylePart.color(tokens.textPrimary),
      TextStylePart.fontSize(36),
      TextStylePart.fontWeight(FontWeight.w900),
      TextStylePart.height(1.05),
    },
    AppTextRole.muted: (tokens) => {
      TextStylePart.color(tokens.textMuted),
      TextStylePart.fontSize(12),
      TextStylePart.fontWeight(FontWeight.w800),
    },
  },
);
