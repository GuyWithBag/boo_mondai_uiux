import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    this.margin = EdgeInsets.zero,
    this.thickness,
    this.color,
    super.key,
  });

  final EdgeInsetsGeometry margin;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      margin: margin,
      height: thickness ?? tokens.borderWidthDefault,
      color: color ?? tokens.borderNeutralSubtle,
    );
  }
}
