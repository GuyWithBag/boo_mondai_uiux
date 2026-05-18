import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../theme/app_variant_styles.dart';
import 'tactile_button.dart';

class EditorCard extends StatelessWidget {
  const EditorCard({required this.title, required this.placeholder, super.key});

  final String title;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      constraints: const BoxConstraints(minHeight: 350),
      padding: const EdgeInsets.all(28),
      decoration: panelDecoration
          .resolve(tokens)
          .copyWith(
            borderRadius: BorderRadius.circular(tokens.radiusContainerLarge),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 1.15,
              ),
              decoration: InputDecoration.collapsed(hintText: placeholder),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.only(top: 18),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
              ),
            ),
            child: const Row(
              children: [
                TactileButton(
                  icon: Icons.image_outlined,
                  size: TactileSize.icon,
                  child: SizedBox.shrink(),
                ),
                SizedBox(width: 12),
                TactileButton(
                  icon: Icons.mic,
                  size: TactileSize.icon,
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
