import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/tactile_button.variant.dart';
import '../../widgets/tactile_button.dart';
import 'tactile_radio_circle.dart';

class MultipleChoiceOption extends HookWidget {
  const MultipleChoiceOption({
    required this.value,
    this.correct = false,
    super.key,
  });

  final String value;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = useTextEditingController(text: value);

    return TactileButton(
      tone: correct ? TactileTone.success : TactileTone.ghost,
      onPressed: () {},
      child: Row(
        children: [
          TactileRadioCircle(correct: correct),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              decoration: const InputDecoration.collapsed(hintText: ''),
            ),
          ),
          IconButton(
            color: tokens.textMuted,
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
