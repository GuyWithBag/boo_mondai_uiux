import 'package:flutter/material.dart';
import 'package:react_to_flutter/theme/app_tokens.dart';
import 'package:theme_variants/theme_variants.dart';

enum TactileSize { sm, md, lg, icon }

enum TactileState { idle, hovered, selected, disabled, pressed }

enum TactileTone { filled, ghost, success, error, streak, dashed, text }

final tactileButtonStyle = VariantStyle.surfaceParts<AppTokens>(
  base: (tokens) => {
    SurfaceStylePart.decoration({
      DecorationPart.color(tokens.backgroundSurface),
      DecorationPart.borderRadius(BorderRadius.circular(tokens.radius2xl)),
      DecorationPart.border(
        Border.all(
          color: tokens.borderNeutralSubtle,
          width: tokens.borderWidthDefault,
        ),
      ),
      DecorationPart.boxShadow([
        BoxShadow(
          color: tokens.borderNeutralSubtle,
          offset: Offset(0, tokens.shadowSecondaryOffset),
        ),
      ]),
    }),
    SurfaceStylePart.text({
      TextStylePart.color(tokens.textSecondary),
      TextStylePart.fontSize(tokens.fontSizeTactileMd),
      TextStylePart.fontWeight(tokens.fontWeightTextStrong),
      TextStylePart.height(tokens.lineHeightTactile),
    }),
    SurfaceStylePart.icon({
      IconThemePart.color(tokens.textSecondary),
      IconThemePart.size(tokens.sizeIconMd),
    }),
  },
  defaultVariants: const [TactileTone.ghost, TactileSize.md, TactileState.idle],
  variants: {
    TactileTone.filled: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.primary),
        DecorationPart.border(
          Border.all(color: tokens.primary, width: tokens.borderWidthDefault),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.primaryDark,
            offset: Offset(0, tokens.shadowPrimaryLgOffset),
          ),
        ]),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.colorTextOnBrand)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.colorTextOnBrand)}),
    },
    TactileTone.ghost: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.backgroundSurface),
        DecorationPart.border(
          Border.all(
            color: tokens.borderNeutralSubtle,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.borderNeutralSubtle,
            offset: Offset(0, tokens.shadowSecondaryOffset),
          ),
        ]),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.textPrimary)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.textPrimary)}),
    },
    TactileTone.success: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.greenSoft),
        DecorationPart.border(
          Border.all(
            color: tokens.actionSuccess,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.actionSuccessLight,
            offset: Offset(0, tokens.shadowFeedbackOffset),
          ),
        ]),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.actionSuccess)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.actionSuccess)}),
    },
    TactileTone.error: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.redSoft),
        DecorationPart.border(
          Border.all(
            color: tokens.actionErrorLight,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.actionErrorLight,
            offset: Offset(0, tokens.shadowFeedbackOffset),
          ),
        ]),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.actionError)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.actionError)}),
    },
    TactileTone.streak: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.streak),
        DecorationPart.border(
          Border.all(color: tokens.streak, width: tokens.borderWidthDefault),
        ),
        DecorationPart.boxShadow([
          BoxShadow(
            color: tokens.streakDark,
            offset: Offset(0, tokens.shadowStreakOffset),
          ),
        ]),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.colorTextOnBrand)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.colorTextOnBrand)}),
    },
    TactileTone.dashed: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.softGray),
        DecorationPart.border(
          Border.all(
            color: tokens.colorTransparent,
            width: tokens.borderWidthDefault,
          ),
        ),
        DecorationPart.boxShadow(const []),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.textMuted)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.textMuted)}),
    },
    TactileTone.text: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.colorTransparent),
        DecorationPart.border(
          Border.all(color: tokens.colorTransparent, width: 0),
        ),
        DecorationPart.boxShadow(const []),
      }),
      SurfaceStylePart.text({TextStylePart.color(tokens.textSecondary)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.textSecondary)}),
    },
    TactileSize.sm: (tokens) => {
      SurfaceStylePart.text({TextStylePart.fontSize(tokens.fontSizeTactileSm)}),
      SurfaceStylePart.icon({IconThemePart.size(tokens.sizeIconMd)}),
    },
    TactileSize.md: (tokens) => {
      SurfaceStylePart.text({TextStylePart.fontSize(tokens.fontSizeTactileMd)}),
      SurfaceStylePart.icon({IconThemePart.size(tokens.sizeIconMd)}),
    },
    TactileSize.lg: (tokens) => {
      SurfaceStylePart.text({TextStylePart.fontSize(tokens.fontSizeTactileLg)}),
      SurfaceStylePart.icon({IconThemePart.size(tokens.sizeIconMd)}),
    },
    TactileSize.icon: (tokens) => {
      SurfaceStylePart.text({
        TextStylePart.fontSize(tokens.fontSizeTactileIcon),
      }),
      SurfaceStylePart.icon({IconThemePart.size(tokens.sizeIconLg)}),
    },
    TactileState.idle: (_) => const <StylePart<SurfaceStyle>>{},
    TactileState.hovered: (_) => const <StylePart<SurfaceStyle>>{},
    TactileState.pressed: (_) => {
      SurfaceStylePart.decoration({DecorationPart.boxShadow(const [])}),
    },
    TactileState.selected: (tokens) => {
      SurfaceStylePart.decoration({
        DecorationPart.color(tokens.indigoSoft),
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
      SurfaceStylePart.text({TextStylePart.color(tokens.primary)}),
      SurfaceStylePart.icon({IconThemePart.color(tokens.primary)}),
    },
    TactileState.disabled: (_) => {
      SurfaceStylePart.decoration({DecorationPart.boxShadow(const [])}),
    },
  },
  compoundVariants: [
    CompoundVariantParts<AppTokens, SurfaceStyle>(
      when: const {TactileTone.dashed, TactileState.hovered},
      build: (tokens) => {
        SurfaceStylePart.decoration({DecorationPart.color(tokens.indigoSoft)}),
        SurfaceStylePart.text({TextStylePart.color(tokens.primary)}),
        SurfaceStylePart.icon({IconThemePart.color(tokens.primary)}),
      },
    ),
    CompoundVariantParts<AppTokens, SurfaceStyle>(
      when: const {TactileTone.ghost, TactileState.selected},
      build: (tokens) => {
        SurfaceStylePart.decoration({
          DecorationPart.color(tokens.indigoSoft),
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
        SurfaceStylePart.text({TextStylePart.color(tokens.primary)}),
        SurfaceStylePart.icon({IconThemePart.color(tokens.primary)}),
      },
    ),
  ],
);

final tactileButtonDecoration = _TactileButtonDecorationStyle();
final tactileButtonText = _TactileButtonTextStyle();

class _TactileButtonDecorationStyle {
  BoxDecoration resolve(
    AppTokens tokens, [
    Iterable<Object> variants = const [],
  ]) {
    return tactileButtonStyle.resolve(tokens, variants).decoration;
  }
}

class _TactileButtonTextStyle {
  TextStyle resolve(AppTokens tokens, [Iterable<Object> variants = const []]) {
    return tactileButtonStyle.resolve(tokens, variants).textStyle;
  }
}
