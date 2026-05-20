import 'package:flutter/material.dart';
import 'package:react_to_flutter/theme/app_tokens.dart';
import 'package:theme_variants/theme_variants.dart';

enum SurfaceTone { surface, selected, success, muted, dark }

final surfaceStyle = VariantStyle.surfaceParts<AppTokens>(
  base: (tokens) => {
    SurfaceStylePart.padding(EdgeInsets.all(tokens.spacePanelPadding)),
    SurfaceStylePart.decoration({
      DecorationPart.color(tokens.backgroundSurface),
      DecorationPart.borderRadius(
        BorderRadius.circular(tokens.radiusContainerLarge),
      ),
      DecorationPart.border(
        Border.all(
          color: tokens.borderNeutralSubtle,
          width: tokens.borderWidthDefault,
        ),
      ),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.borderNeutralSubtle.withValues(alpha: 0.55),
          offset: const Offset(0, 4),
          blurRadius: 12,
        ),
      ]),
    }),
  },
  defaultVariants: const [SurfaceTone.surface],
  variants: {
    SurfaceTone.surface: (_) => const {},
    SurfaceTone.selected: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.primarySoft),
        DecorationPart.border(
          Border.all(
            color: tokens.primaryLight,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.primaryLight,
            offset: Offset(0, tokens.shadowGhostOffset),
          ),
        ]),
      }),
    },
    SurfaceTone.success: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.greenSoft),
        DecorationPart.border(
          Border.all(
            color: tokens.actionSuccess,
            width: tokens.borderWidthDefault,
          ),
        ),
      }),
    },
    SurfaceTone.muted: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.softGray),
        DecorationPart.border(
          Border.all(
            color: tokens.borderNeutralSubtle,
            width: tokens.borderWidthDefault,
          ),
        ),
      }),
    },
    SurfaceTone.dark: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.primaryDark),
        DecorationPart.radius(tokens.radiusContainerLarge),
        DecorationPart.border(
          Border.all(
            color: tokens.primaryDark,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.primaryDark.withValues(alpha: 0.35),
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ]),
      }),
    },
  },
);
