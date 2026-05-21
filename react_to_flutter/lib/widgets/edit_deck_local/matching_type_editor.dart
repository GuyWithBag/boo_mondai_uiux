import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/tactile_button.dart';
import 'matching_type_pair.dart';

class MatchingTypeEditor extends StatelessWidget {
  const MatchingTypeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Matching Pairs'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [
              TextSize.labelSmall,
              TextWeight.heavy,
              TextTone.muted,
            ]),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 44),
              Expanded(
                child: Text(
                  'TERM',
                  style: appTextStyle.resolve(tokens, [
                    TextSize.labelSmall,
                    TextWeight.heavy,
                    TextTone.muted,
                  ]),
                ),
              ),
              const SizedBox(width: 56),
              Expanded(
                child: Text(
                  'MATCH',
                  style: appTextStyle.resolve(tokens, [
                    TextSize.labelSmall,
                    TextWeight.heavy,
                    TextTone.muted,
                  ]),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 12),
          const MatchPair(term: '犬', match: 'Dog'),
          const SizedBox(height: 14),
          const MatchPair(term: '猫', match: 'Cat'),
          const SizedBox(height: 28),
          TactileButton(
            leading: Icon(Icons.add),
            tone: TactileTone.dashed,
            onPressed: () {},
            child: Text('Add Pair'),
          ),
        ],
      ),
    );
  }
}
