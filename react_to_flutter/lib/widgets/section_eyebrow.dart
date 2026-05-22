import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../variant_styles/variant_styles.barrel.dart';

class SectionEyebrow extends StatelessWidget {
  const SectionEyebrow(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Text(
      label.toUpperCase(),
      style: appTextStyle.resolve(tokens, [
        TextSize.labelSmall,
        TextWeight.heavy,
        TextTone.muted,
      ]),
    );
  }
}
