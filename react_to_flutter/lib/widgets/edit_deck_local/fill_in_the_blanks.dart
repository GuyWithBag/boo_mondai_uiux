import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/tactile_button.dart';

class FillInTheBlanks extends StatelessWidget {
  const FillInTheBlanks({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sentence Builder'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [
              TextSize.labelSmall,
              TextWeight.heavy,
              TextTone.muted,
            ]),
          ),
          const SizedBox(height: 14),
          Text(
            'Type your full sentence below. Highlight the words you want the user to guess, and click "Create Blank".',
            style: appTextStyle
                .resolve(tokens, [
                  TextSize.label,
                  TextWeight.body,
                  TextTone.secondary,
                ])
                .copyWith(fontSize: 17),
          ),
          const SizedBox(height: 28),
          Surface(
            style: surfaceStyle.resolve(tokens, const [SurfaceTone.muted]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '私は毎日',
                      style: TextStyle(
                        color: tokens.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.6,
                      ),
                    ),
                    TactileButton(
                      tone: TactileTone.filled,
                      alignment: TactileAlign.fit,
                      child: Text(
                        '図書館',
                        style: appTextStyle.resolve(tokens, [
                          TextSize.labelLarge,
                          TextWeight.heavy,
                          TextTone.primary,
                        ]),
                      ),
                    ),
                    Text(
                      'で勉強します。',
                      style: TextStyle(
                        color: tokens.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerRight,
                  child: TactileButton(
                    icon: Icons.cleaning_services,
                    onPressed: () {},
                    child: Text('Create Blank'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Text(
            'Hidden Segments'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [
              TextSize.labelSmall,
              TextWeight.heavy,
              TextTone.primary,
            ]),
          ),
          const SizedBox(height: 14),
          Surface(
            style: surfaceStyle.resolve(tokens, const [SurfaceTone.muted]),
            child: Row(
              children: [
                TactileButton(size: TactileSize.lg, child: Text('1')),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct Answer'.toUpperCase(),
                        style: appTextStyle.resolve(tokens, [
                          TextSize.labelSmall,
                          TextWeight.heavy,
                          TextTone.muted,
                        ]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '図書館 (Library)',
                        style: TextStyle(
                          color: tokens.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: tokens.actionError),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
