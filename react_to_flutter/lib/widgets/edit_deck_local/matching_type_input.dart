import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';

class MatchingTypeInput extends HookWidget {
  const MatchingTypeInput({required this.value, super.key});

  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = useTextEditingController(text: value);

    return TextField(
      controller: controller,
      style: TextStyle(
        color: tokens.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: tokens.backgroundPage,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius2xl),
          borderSide: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius2xl),
          borderSide: BorderSide(color: tokens.primary, width: 2),
        ),
      ),
    );
  }
}
