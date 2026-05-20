import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/tactile_button.variant.dart';
import '../../widgets/tactile_button.dart';

class EditDeckSidebar extends StatelessWidget {
  const EditDeckSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      width: 288.w,
      decoration: BoxDecoration(
        color: tokens.backgroundSurface,
        border: Border(
          right: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            color: tokens.softGray,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Cards (3)',
                    style: TextStyle(
                      color: tokens.textPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                TactileButton.iconOnly(onPressed: () {}, icon: Icons.add),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                TactileButton(
                  selected: true,
                  onPressed: () {},
                  icon: Icons.slideshow_outlined,
                  alignment: TactileAlign.start,
                  tone: TactileTone.ghost,
                  child: Text('勉強 (benkyou)'),
                ),
                SizedBox(height: 12),
                TactileButton(
                  icon: Icons.list,
                  onPressed: () {},
                  alignment: TactileAlign.start,
                  tone: TactileTone.text,
                  child: Text('Which particle is...'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
