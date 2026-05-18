import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import 'app_tokens.dart';

const _lightTokens = AppTokens.light();
const _darkTokens = AppTokens.dark();

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
  id: 'boomondai-light',
  themeData: _themeData(_lightTokens, Brightness.light),
  tokens: _lightTokens,
);

final booMondaiDark = ThemeVariant<AppTokens>(
  id: 'boomondai-dark',
  themeData: _themeData(_darkTokens, Brightness.dark),
  tokens: _darkTokens,
);

final appThemeRegistry = ThemeVariantRegistry<AppTokens>(
  themes: {
    'boomondai': LightDarkThemeVariant<AppTokens>(
      light: booMondaiLight,
      dark: booMondaiDark,
    ),
  },
);

ThemeVariantsController<AppTokens> createAppThemeController() {
  return ThemeVariantsController<AppTokens>(
    registry: appThemeRegistry,
    lightThemeId: 'boomondai',
    darkThemeId: 'boomondai',
    themeMode: ThemeMode.system,
  );
}
