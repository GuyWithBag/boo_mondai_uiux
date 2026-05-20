import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import 'matching_type_input.dart';

class MatchPair extends StatelessWidget {
  const MatchPair({required this.term, required this.match, super.key});

  final String term;
  final String match;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Row(
      children: [
        Icon(Icons.drag_indicator, color: tokens.textMuted),
        const SizedBox(width: 12),
        Expanded(child: MatchingTypeInput(value: term)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(Icons.compare_arrows, color: tokens.textMuted),
        ),
        Expanded(child: MatchingTypeInput(value: match)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: tokens.textMuted),
        ),
      ],
    );
  }
}
