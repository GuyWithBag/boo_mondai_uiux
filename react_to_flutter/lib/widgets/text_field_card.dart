import 'package:flutter/material.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';

import 'tactile_button.dart';

class TextFieldCard extends StatelessWidget {
  const TextFieldCard({
    required this.title,
    required this.placeholder,
    super.key,
  });

  final String title;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final resolvedSurfaceStyle = surfaceStyle.resolve(tokens);

    return Surface(
      style: resolvedSurfaceStyle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          SizedBox(height: tokens.spacePanelGapLg),
          Expanded(
            child: TextField(
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: tokens.fontSizeFieldDisplay,
                fontWeight: tokens.fontWeightTextStrong,
                height: tokens.lineHeightFieldDisplay,
              ),
              decoration: InputDecoration.collapsed(hintText: placeholder),
            ),
          ),
          Column(
            children: [
              Divider(),
              SizedBox(height: tokens.spacePanelGapMd),
            ],
          ),
          Row(
            children: [
              TactileButton(
                onPressed: () {},
                icon: Icons.image_outlined,
                size: TactileSize.icon,
              ),
              SizedBox(width: tokens.spacePanelGapSm),
              TactileButton(
                onPressed: () {},
                icon: Icons.mic,
                size: TactileSize.icon,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
