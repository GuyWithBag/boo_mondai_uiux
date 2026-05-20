import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';
import '../widgets/tactile_button.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = context.themeVariantsController<AppTokens>();
    final mode = controller.themeMode;
    final pages = useMemoized(
      () => const [
        _HomeDestination(
          title: 'Creator Studio',
          description: 'Build flashcards, MCQs, blanks, and matching pairs.',
          icon: Icons.edit_note,
          route: '/creator',
          tone: TactileTone.filled,
        ),
        _HomeDestination(
          title: 'Design System',
          description: 'Review the tactile tokens, typography, and components.',
          icon: Icons.palette,
          route: '/design-system',
          tone: TactileTone.ghost,
        ),
      ],
    );

    return Scaffold(
      backgroundColor: tokens.backgroundPage,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.w),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 920.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      _ThemeModeButton(
                        label: 'Light',
                        icon: Icons.light_mode,
                        selected: mode == ThemeMode.light,
                        onPressed: () =>
                            controller.setThemeMode(ThemeMode.light),
                      ),
                      _ThemeModeButton(
                        label: 'Dark',
                        icon: Icons.dark_mode,
                        selected: mode == ThemeMode.dark,
                        onPressed: () =>
                            controller.setThemeMode(ThemeMode.dark),
                      ),
                      _ThemeModeButton(
                        label: 'System',
                        icon: Icons.settings_suggest,
                        selected: mode == ThemeMode.system,
                        onPressed: () =>
                            controller.setThemeMode(ThemeMode.system),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    width: 56.w,
                    height: 56.w,
                    decoration: BoxDecoration(
                      color: tokens.primary,
                      borderRadius: BorderRadius.circular(tokens.radius2xl.r),
                      boxShadow: [
                        BoxShadow(
                          color: tokens.primaryDark,
                          offset: Offset(0, 5.h),
                        ),
                      ],
                    ),
                    child: const Icon(Icons.auto_awesome, color: Colors.white),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'BooMondai Flutter',
                    style: TextStyle(
                      color: tokens.textPrimary,
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w900,
                      height: 1.05,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Choose a converted Flutter page.',
                    style: TextStyle(
                      color: tokens.textSecondary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 36.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth >= 720.w;
                      return Wrap(
                        spacing: 24.w,
                        runSpacing: 24.h,
                        children: [
                          for (final page in pages)
                            SizedBox(
                              width: isWide
                                  ? (constraints.maxWidth - 24.w) / 2
                                  : constraints.maxWidth,
                              child: _DestinationCard(destination: page),
                            ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeModeButton extends StatelessWidget {
  const _ThemeModeButton({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      tone: selected ? TactileTone.filled : TactileTone.ghost,
      size: TactileSize.sm,
      icon: icon,
      selected: selected,
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class _DestinationCard extends HookWidget {
  const _DestinationCard({required this.destination});

  final _HomeDestination destination;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final hovered = useState(false);

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOutCubic,
        scale: hovered.value ? 1.015 : 1,
        child: Surface(
          style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TactileButton(child: Icon(destination.icon)),
              SizedBox(height: 22.h),
              Text(
                destination.title,
                style: TextStyle(
                  color: tokens.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                destination.description,
                style: TextStyle(
                  color: tokens.textSecondary,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: TactileButton(
                  tone: destination.tone,
                  icon: Icons.arrow_forward,
                  onPressed: () => context.go(destination.route),
                  child: Text('Open'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeDestination {
  const _HomeDestination({
    required this.title,
    required this.description,
    required this.icon,
    required this.route,
    required this.tone,
  });

  final String title;
  final String description;
  final IconData icon;
  final String route;
  final TactileTone tone;
}
