import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/tactile_button.variant.dart';
import '../../widgets/panel_header.dart';
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
          PanelHeader(
            title: 'Cards (3)',
            trailing: TactileButton.icon(onPressed: () {}, icon: Icons.add),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                TactileButton(
                  selected: true,
                  onPressed: () {},
                  leading: Icon(Icons.slideshow_outlined),
                  mainAxisAlignment: MainAxisAlignment.start,
                  tone: TactileTone.ghost,
                  child: Text('勉強 (benkyou)'),
                ),
                SizedBox(height: 12),
                TactileButton(
                  leading: Icon(Icons.list),
                  onPressed: () {},
                  mainAxisAlignment: MainAxisAlignment.start,
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
