import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';

class DesignSection extends StatelessWidget {
  const DesignSection({
    required this.title,
    required this.child,
    this.margin = const EdgeInsets.only(bottom: 44),
    super.key,
  });

  final String title;
  final Widget child;
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
              ),
            ),
            child: Text(
              title.toUpperCase(),
              style: appTextStyle.resolve(tokens, [
                TextSize.labelSmall,
                TextWeight.heavy,
                TextTone.muted,
              ]),
            ),
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}
