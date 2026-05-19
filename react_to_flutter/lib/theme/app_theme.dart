import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import 'app_tokens.dart';

const _lightTokens = defaultLight;
const _darkTokens = defaultDark;

ThemeData _themeData(AppTokens tokens, Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: tokens.primary,
    brightness: brightness,
    primary: tokens.primary,
    surface: tokens.backgroundSurface,
    error: tokens.actionError,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: tokens.backgroundPage,
    fontFamily: tokens.fontFamilySans,
    dividerTheme: DividerThemeData(
      color: tokens.borderNeutralSubtle,
      thickness: tokens.borderWidthDefault,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: tokens.primary.withValues(alpha: 0.22),
      cursorColor: tokens.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        color: tokens.textMuted.withValues(alpha: 0.65),
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

final booMondaiLight = ThemeVariant<AppTokens>(
  themePresetId: 'boomondai',
  brightness: ThemeVariantBrightness.light,
  themeData: _themeData(_lightTokens, Brightness.light),
  tokens: _lightTokens,
);

final booMondaiDark = ThemeVariant<AppTokens>(
  themePresetId: 'boomondai',
  brightness: ThemeVariantBrightness.dark,
  themeData: _themeData(_darkTokens, Brightness.dark),
  tokens: _darkTokens,
);

final booMondaiPreset = LightDarkThemePreset<AppTokens>(
  id: 'boomondai',
  name: 'BooMondai',
  light: booMondaiLight,
  dark: booMondaiDark,
);

final appThemeRegistry = ThemeVariantRegistry<AppTokens>(
  presets: [booMondaiPreset],
);

ThemeVariantsController<AppTokens> createAppThemeController() {
  return ThemeVariantsController<AppTokens>(
    registry: appThemeRegistry,
    lightThemeId: 'boomondai',
    darkThemeId: 'boomondai',
    themeMode: ThemeMode.system,
  );
}
