import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';

enum StatusBadgeTone { brand, neutral, success, error }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    required this.label,
    this.tone = StatusBadgeTone.brand,
    super.key,
  });

  final String label;
  final StatusBadgeTone tone;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final colors = switch (tone) {
      StatusBadgeTone.brand => (
        background: tokens.primarySoft,
        border: tokens.primaryBright,
        text: tokens.primary,
      ),
      StatusBadgeTone.neutral => (
        background: tokens.softGray,
        border: tokens.borderNeutralSubtle,
        text: tokens.textSecondary,
      ),
      StatusBadgeTone.success => (
        background: tokens.actionSuccess.withValues(alpha: 0.12),
        border: tokens.actionSuccess,
        text: tokens.actionSuccess,
      ),
      StatusBadgeTone.error => (
        background: tokens.actionError.withValues(alpha: 0.12),
        border: tokens.actionError,
        text: tokens.actionError,
      ),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(
          color: colors.border,
          width: tokens.borderWidthDefault,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: colors.text,
          fontSize: tokens.textSizeLabelSmall.sp,
          fontWeight: tokens.fontWeightTextHeavy,
          letterSpacing: tokens.letterSpacingTextEyebrow,
        ),
      ),
    );
  }
}
