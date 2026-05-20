import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/tactile_button.dart';
import 'multiple_choice_option.dart';

class MultipleChoiceOptionsPanel extends StatelessWidget {
  const MultipleChoiceOptionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Answer Options'.toUpperCase(),
                  style: appTextStyle.resolve(tokens, [
                    TextSize.labelSmall,
                    TextWeight.heavy,
                    TextTone.muted,
                  ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: tokens.primarySoft,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tokens.primaryLight),
                ),
                child: Text(
                  'Select correct',
                  style: TextStyle(
                    color: tokens.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const MultipleChoiceOption(correct: true, value: 'To study'),
          const SizedBox(height: 14),
          const MultipleChoiceOption(value: 'To eat'),
          const Spacer(),
          const SizedBox(height: 20),
          TactileButton(
            icon: Icons.add,
            tone: TactileTone.dashed,
            onPressed: () {},
            child: Text('Add Option'),
          ),
        ],
      ),
    );
  }
}
