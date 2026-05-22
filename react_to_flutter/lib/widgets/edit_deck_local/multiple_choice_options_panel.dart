import 'package:flutter/material.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/tactile_radio_circle.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/section_eyebrow.dart';
import '../../widgets/status_badge.dart';
import '../../widgets/tactile_button.dart';

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
              const Expanded(child: SectionEyebrow('Answer Options')),
              const StatusBadge(label: 'Select correct'),
            ],
          ),
          const SizedBox(height: 22),
          TactileButton(
            tone: TactileTone.success,
            depth: TactileDepth.flat,
            leading: TactileRadioCircle(correct: true),
            mainAxisAlignment: MainAxisAlignment.start,
            child: Text('To study'),
          ),
          const SizedBox(height: 14),
          TactileButton(
            tone: TactileTone.ghost,
            depth: TactileDepth.flat,
            mainAxisAlignment: MainAxisAlignment.start,
            leading: TactileRadioCircle(correct: false),
            child: Text('To eat'),
          ),
          const Spacer(),
          const SizedBox(height: 20),
          TactileButton(
            leading: Icon(Icons.add),
            tone: TactileTone.dashed,
            onPressed: () {},
            child: Text('Add Option'),
          ),
        ],
      ),
    );
  }
}
