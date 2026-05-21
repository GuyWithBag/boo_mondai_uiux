import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/tactile_button.variant.dart';
import '../../widgets/tactile_button.dart';

class EditDeckAppbar extends HookWidget implements PreferredSizeWidget {
  const EditDeckAppbar({required this.tokens, super.key});

  static const double height = 88;

  final AppTokens tokens;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: 'JLPT N5 Grammar');
    final horizontalPadding = 24.w;
    final verticalPadding = 16.h;
    final actionGap = 12.w;

    return AppBar(
      leadingWidth: 100.w,
      leading: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding + 4,
        ),
        child: TactileButton.icon(
          icon: Icons.arrow_back,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
              return;
            }
            context.go('/');
          },
        ),
      ),
      title: SizedBox(
        height: preferredSize.height,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: tokens.primarySoft,
                      borderRadius: BorderRadius.circular(7.r),
                      border: Border.all(color: tokens.primaryBright, width: 2),
                    ),
                    child: Text(
                      'DRAFT DECK',
                      style: TextStyle(
                        color: tokens.primary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  Icon(Icons.lock, color: tokens.textMuted, size: 14.sp),
                  Text(
                    'Private',
                    style: TextStyle(
                      color: tokens.textMuted,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              TextField(
                controller: titleController,
                style: TextStyle(
                  color: tokens.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
                decoration: const InputDecoration.collapsed(
                  hintText: 'Deck Title...',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TactileButton(
                tone: TactileTone.text,
                leading: Icon(Icons.settings),
                onPressed: () => context.go('/design-system'),
                child: Text('Settings'),
              ),
              SizedBox(width: actionGap),
              TactileButton(
                tone: TactileTone.filled,
                onPressed: () {},
                child: Text('Save & Close'),
              ),
            ],
          ),
        ),
        SizedBox(width: horizontalPadding),
      ],
    );
  }
}
