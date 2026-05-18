import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import 'app_tokens.dart';

enum TactileTone { primary, secondary, ghost, success, error, streak, text }

enum TactileSize { sm, md, lg, icon }

enum TactileState { idle, selected, disabled }

enum PanelTone { surface, selected, success, muted, dark }

enum AppTextRole { eyebrow, body, title, display, muted }

final tactileButtonDecoration = VariantStyle.decoration<AppTokens>(
  base: (tokens) => BoxDecoration(
    color: tokens.backgroundSurface,
    borderRadius: BorderRadius.circular(tokens.radius2xl),
    border: Border.all(color: tokens.borderNeutralSubtle, width: 2),
    boxShadow: [
      BoxShadow(
        color: tokens.borderNeutralSubtle,
        offset: Offset(0, tokens.shadowSecondaryOffset),
      ),
    ],
  ),
  defaultVariants: const [TactileTone.secondary, TactileState.idle],
  variants: {
    TactileTone.primary: (tokens) => BoxDecoration(
      color: tokens.primary,
      border: Border.all(color: tokens.primary, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.primaryDark,
          offset: Offset(0, tokens.shadowPrimaryLgOffset),
        ),
      ],
    ),
    TactileTone.secondary: (tokens) => BoxDecoration(
      color: tokens.backgroundSurface,
      border: Border.all(color: tokens.borderNeutralSubtle, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.borderNeutralSubtle,
          offset: Offset(0, tokens.shadowSecondaryOffset),
        ),
      ],
    ),
    TactileTone.ghost: (tokens) => BoxDecoration(
      color: tokens.indigoSoft,
      border: Border.all(color: tokens.primaryLight, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ],
    ),
    TactileTone.success: (tokens) => BoxDecoration(
      color: tokens.greenSoft,
      border: Border.all(color: tokens.actionSuccess, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.actionSuccessLight,
          offset: Offset(0, tokens.shadowFeedbackOffset),
        ),
      ],
    ),
    TactileTone.error: (tokens) => BoxDecoration(
      color: tokens.redSoft,
      border: Border.all(color: tokens.actionErrorLight, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.actionErrorLight,
          offset: Offset(0, tokens.shadowFeedbackOffset),
        ),
      ],
    ),
    TactileTone.streak: (tokens) => BoxDecoration(
      color: tokens.streak,
      border: Border.all(color: tokens.streak, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.streakDark,
          offset: Offset(0, tokens.shadowStreakOffset),
        ),
      ],
    ),
    TactileTone.text: (_) => const BoxDecoration(color: Colors.transparent),
    TactileState.selected: (tokens) => BoxDecoration(
      color: tokens.indigoSoft,
      border: Border.all(color: tokens.primaryLight, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ],
    ),
    TactileState.disabled: (_) => const BoxDecoration(boxShadow: []),
  },
);

final tactileButtonText = VariantStyle.text<AppTokens>(
  base: (tokens) => TextStyle(
    color: tokens.textSecondary,
    fontSize: 16,
    fontWeight: FontWeight.w800,
    height: 1.1,
  ),
  defaultVariants: const [TactileTone.secondary, TactileSize.md],
  variants: {
    TactileTone.primary: (_) => const TextStyle(color: Colors.white),
    TactileTone.secondary: (tokens) => TextStyle(color: tokens.textPrimary),
    TactileTone.ghost: (tokens) => TextStyle(color: tokens.primary),
    TactileTone.success: (tokens) => TextStyle(color: tokens.actionSuccess),
    TactileTone.error: (tokens) => TextStyle(color: tokens.actionError),
    TactileTone.streak: (_) => const TextStyle(color: Colors.white),
    TactileTone.text: (tokens) => TextStyle(color: tokens.primary),
    TactileSize.sm: (_) => const TextStyle(fontSize: 14),
    TactileSize.lg: (_) => const TextStyle(fontSize: 18),
    TactileSize.icon: (_) => const TextStyle(fontSize: 0),
  },
);

final panelDecoration = VariantStyle.decoration<AppTokens>(
  base: (tokens) => BoxDecoration(
    color: tokens.backgroundSurface,
    borderRadius: BorderRadius.circular(tokens.radiusContainerLarge),
    border: Border.all(color: tokens.borderNeutralSubtle, width: 2),
  ),
  defaultVariants: const [PanelTone.surface],
  variants: {
    PanelTone.selected: (tokens) => BoxDecoration(
      color: tokens.indigoSoft,
      border: Border.all(color: tokens.primaryLight, width: 2),
      boxShadow: [
        BoxShadow(
          color: tokens.primaryLight,
          offset: Offset(0, tokens.shadowGhostOffset),
        ),
      ],
    ),
    PanelTone.success: (tokens) => BoxDecoration(
      color: tokens.greenSoft,
      border: Border.all(color: tokens.actionSuccess, width: 2),
    ),
    PanelTone.muted: (tokens) => BoxDecoration(
      color: tokens.softGray,
      border: Border.all(color: tokens.borderNeutralSubtle, width: 2),
    ),
    PanelTone.dark: (_) => BoxDecoration(
      color: const Color(0xff312e81),
      borderRadius: BorderRadius.circular(40),
    ),
  },
);

final appTextStyle = VariantStyle.text<AppTokens>(
  base: (tokens) =>
      TextStyle(color: tokens.textPrimary, fontWeight: FontWeight.w700),
  defaultVariants: const [AppTextRole.body],
  variants: {
    AppTextRole.eyebrow: (tokens) => TextStyle(
      color: tokens.textMuted,
      fontSize: 10,
      fontWeight: FontWeight.w900,
      letterSpacing: 1.6,
    ),
    AppTextRole.body: (tokens) => TextStyle(
      color: tokens.textSecondary,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      height: 1.45,
    ),
    AppTextRole.title: (tokens) => TextStyle(
      color: tokens.textPrimary,
      fontSize: 22,
      fontWeight: FontWeight.w900,
      height: 1.1,
    ),
    AppTextRole.display: (tokens) => TextStyle(
      color: tokens.textPrimary,
      fontSize: 36,
      fontWeight: FontWeight.w900,
      height: 1.05,
    ),
    AppTextRole.muted: (tokens) => TextStyle(
      color: tokens.textMuted,
      fontSize: 12,
      fontWeight: FontWeight.w800,
    ),
  },
);
