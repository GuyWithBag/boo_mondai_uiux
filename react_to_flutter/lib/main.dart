import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:react_to_flutter/pages/edit_deck.local.page.dart';
import 'package:theme_variants/theme_variants.dart';

import 'pages/design_system.page.dart';
import 'pages/home.page.dart';
import 'theme/app_theme.dart';
import 'theme/app_tokens.dart';

void main() {
  runApp(const BooMondaiApp());
}

class BooMondaiApp extends HookWidget {
  const BooMondaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useMemoized(createAppThemeController);
    final router = useMemoized(
      () => GoRouter(
        routes: [
          GoRoute(path: '/', builder: (context, state) => const HomePage()),
          GoRoute(
            path: '/creator',
            builder: (context, state) => const EditDeckPage(),
          ),
          GoRoute(
            path: '/design-system',
            builder: (context, state) => const DesignSystemPage(),
          ),
        ],
      ),
    );

    useEffect(() {
      return () {
        router.dispose();
        controller.dispose();
      };
    }, [controller, router]);

    return ThemeVariantsProvider<AppTokens>(
      controller: controller,
      child: ScreenUtilInit(
        designSize: const Size(1920, 1080),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, _) => AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'BooMondai Flutter',
              theme: controller.getCurrentLightTheme().themeData,
              darkTheme: controller.getCurrentDarkTheme().themeData,
              themeMode: controller.themeMode,
              routerConfig: router,
            );
          },
        ),
      ),
    );
  }
}
