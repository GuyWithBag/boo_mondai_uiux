import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../theme/app_variant_styles.dart';

class AppPanel extends StatelessWidget {
  const AppPanel({
    required this.child,
    this.tone = PanelTone.surface,
    this.padding = const EdgeInsets.all(28),
    this.radius,
    super.key,
  });

  final Widget child;
  final PanelTone tone;
  final EdgeInsetsGeometry padding;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    var decoration = panelDecoration.resolve(tokens, [tone]);
    if (radius != null) {
      decoration = decoration.copyWith(
        borderRadius: BorderRadius.circular(radius!),
      );
    }

    return Container(padding: padding, decoration: decoration, child: child);
  }
}
