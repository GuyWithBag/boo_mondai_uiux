import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../variant_styles/variant_styles.barrel.dart';
import '../variant_text_field.dart';

class MatchingTypeInput extends HookWidget {
  const MatchingTypeInput({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController(text: value);

    return VariantTextField(
      controller: controller,
      variants: const [
        AppTextFieldSize.labelLarge,
        AppTextFieldFrame.outline,
        AppTextFieldTone.neutral,
      ],
    );
  }
}
