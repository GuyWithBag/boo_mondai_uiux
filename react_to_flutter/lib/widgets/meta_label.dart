import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../variant_styles/variant_styles.barrel.dart';

class MetaLabel extends StatelessWidget {
  const MetaLabel({required this.label, this.icon, super.key});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: tokens.textMuted, size: tokens.sizeIconMd.sp),
          SizedBox(width: 4.w),
        ],
        Text(
          label,
          style: appTextStyle.resolve(tokens, [
            TextSize.labelSmall,
            TextWeight.strong,
            TextTone.muted,
          ]),
        ),
      ],
    );
  }
}
