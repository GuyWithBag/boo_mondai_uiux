import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/segmented_control.dart';
import 'types.dart';

class DirectionSelector extends StatelessWidget {
  const DirectionSelector({
    required this.selected,
    required this.hint,
    required this.onChanged,
    super.key,
  });

  final DirectionType selected;
  final String hint;
  final ValueChanged<DirectionType> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    const options = [
      SegmentOption(value: DirectionType.normal, label: 'Normal'),
      SegmentOption(value: DirectionType.reverse, label: 'Reversed'),
      SegmentOption(value: DirectionType.both, label: 'Both Ways'),
    ];

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Wrap(
        spacing: 18,
        runSpacing: 18,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Study Direction',
                  style: appTextStyle
                      .resolve(tokens, [
                        TextSize.labelLarge,
                        TextWeight.heavy,
                        TextTone.primary,
                      ])
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  hint,
                  style: appTextStyle.resolve(tokens, [
                    TextSize.label,
                    TextWeight.body,
                    TextTone.secondary,
                  ]),
                ),
              ],
            ),
          ),
          SegmentedControl<DirectionType>(
            options: options,
            value: selected,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
