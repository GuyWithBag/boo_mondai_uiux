import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:react_to_flutter/widgets/design_section.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';
import '../widgets/tactile_button.dart';

class DesignSystemPage extends HookWidget {
  const DesignSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Scaffold(
      backgroundColor: tokens.backgroundPage,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 56),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1180),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Header(tokens: tokens),
                      const SizedBox(height: 64),
                      const _PhilosophySection(),
                      _ColorSection(tokens: tokens),
                      const _TypographySection(),
                      const _SurfaceSection(),
                      const _ButtonLabSection(),
                      const _RoadmapSection(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 32,
            right: 32,
            child: TactileButton.icon(
              icon: Icons.close,
              onPressed: () => context.go('/'),
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.tokens});

  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          runSpacing: 16,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: tokens.primary,
                borderRadius: BorderRadius.circular(tokens.radius2xl),
                boxShadow: [
                  BoxShadow(
                    color: tokens.primaryDark,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.auto_awesome, color: Colors.white),
            ),
            Text.rich(
              TextSpan(
                text: 'BooMondai ',
                children: [
                  TextSpan(
                    text: 'Design System',
                    style: TextStyle(color: tokens.primary),
                  ),
                ],
              ),
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: 38,
                fontWeight: FontWeight.w900,
                height: 1.05,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text.rich(
            TextSpan(
              text:
                  'A tactile, low-cognitive-load framework designed for neurodivergent learners. Focusing on ',
              children: [
                TextSpan(
                  text: 'immediate feedback',
                  style: TextStyle(
                    color: tokens.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const TextSpan(text: ', '),
                TextSpan(
                  text: 'spatial consistency',
                  style: TextStyle(
                    color: tokens.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const TextSpan(text: ', and '),
                TextSpan(
                  text: 'sensory delight',
                  style: TextStyle(
                    color: tokens.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const TextSpan(text: '.'),
              ],
            ),
            style: TextStyle(
              color: tokens.textSecondary,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
        ),
      ],
    );
  }
}

class _PhilosophySection extends StatelessWidget {
  const _PhilosophySection();

  @override
  Widget build(BuildContext context) {
    final items = [
      (
        Icons.psychology,
        'Reduced Cognitive Load',
        'We use "Chunking" to prevent overwhelm. Every screen has one primary action. Minimalistic sidebars and clear headers provide constant spatial orientation.',
        TactileTone.ghost,
      ),
      (
        Icons.fingerprint,
        'Tactile Feedback',
        'Buttons have physical depth. When pressed, they move 4px down, mimicking real-world haptics and creating a satisfying sensory loop.',
        TactileTone.streak,
      ),
      (
        Icons.history,
        'Memory Retrieval',
        'Color-coded FSRS ratings help map abstract memory states to concrete visual cues, accelerating spaced repetition learning.',
        TactileTone.success,
      ),
    ];

    return DesignSection(
      title: '01. Experience Philosophy',
      child: _ResponsiveGrid(
        minItemWidth: 280,
        children: [
          for (final item in items)
            _InfoCard(
              icon: item.$1,
              title: item.$2,
              body: item.$3,
              tone: item.$4,
            ),
        ],
      ),
    );
  }
}

class _ColorSection extends StatelessWidget {
  const _ColorSection({required this.tokens});

  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    return DesignSection(
      title: '02. Color Palette',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TokenSwatchGroup(
            title: 'Brand',
            swatches: [
              _TokenSwatch('primary', tokens.primary),
              _TokenSwatch('primaryDark', tokens.primaryDark),
              _TokenSwatch('primaryLight', tokens.primaryLight),
              _TokenSwatch('primarySoft', tokens.primarySoft),
              _TokenSwatch('streak', tokens.streak),
              _TokenSwatch('streakDark', tokens.streakDark),
            ],
          ),
          const SizedBox(height: 28),
          _TokenSwatchGroup(
            title: 'Surface & Text',
            swatches: [
              _TokenSwatch('backgroundPage', tokens.backgroundPage),
              _TokenSwatch('backgroundSurface', tokens.backgroundSurface),
              _TokenSwatch('softGray', tokens.softGray),
              _TokenSwatch('borderNeutralSubtle', tokens.borderNeutralSubtle),
              _TokenSwatch('textPrimary', tokens.textPrimary),
              _TokenSwatch('textSecondary', tokens.textSecondary),
              _TokenSwatch('textMuted', tokens.textMuted),
            ],
          ),
          const SizedBox(height: 28),
          _TokenSwatchGroup(
            title: 'Actions',
            swatches: [
              _TokenSwatch('actionSuccess', tokens.actionSuccess),
              _TokenSwatch('actionError', tokens.actionError),
            ],
          ),
          const SizedBox(height: 28),
          _TokenSwatchGroup(
            title: 'Ratings',
            swatches: [
              _TokenSwatch(
                'ratingAgainBackground',
                tokens.ratingAgainBackground,
              ),
              _TokenSwatch('ratingAgainText', tokens.ratingAgainText),
              _TokenSwatch('ratingAgainBorder', tokens.ratingAgainBorder),
              _TokenSwatch('ratingHardBackground', tokens.ratingHardBackground),
              _TokenSwatch('ratingHardText', tokens.ratingHardText),
              _TokenSwatch('ratingHardBorder', tokens.ratingHardBorder),
              _TokenSwatch('ratingGoodBackground', tokens.ratingGoodBackground),
              _TokenSwatch('ratingGoodText', tokens.ratingGoodText),
              _TokenSwatch('ratingGoodBorder', tokens.ratingGoodBorder),
              _TokenSwatch('ratingEasyBackground', tokens.ratingEasyBackground),
              _TokenSwatch('ratingEasyText', tokens.ratingEasyText),
              _TokenSwatch('ratingEasyBorder', tokens.ratingEasyBorder),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypographySection extends StatelessWidget {
  const _TypographySection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return DesignSection(
      title: '03. Typography',
      child: Surface(
        style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TypeSpec(
              label: 'TextSize.header + TextWeight.heavy + TextTone.primary',
              text: 'Learning Made Tactile',
              style: appTextStyle.resolve(tokens, [
                TextSize.header,
                TextWeight.heavy,
                TextTone.primary,
              ]),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label:
                  'TextSize.labelLarge + TextWeight.heavy + TextTone.primary',
              text: 'Ready for your review?',
              style: appTextStyle.resolve(tokens, [
                TextSize.labelLarge,
                TextWeight.heavy,
                TextTone.primary,
              ]),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label: 'TextSize.label + TextWeight.body + TextTone.secondary',
              text:
                  'The quick brown flashcard uses label text for compact supporting copy.',
              style: appTextStyle.resolve(tokens, [
                TextSize.label,
                TextWeight.body,
                TextTone.secondary,
              ]),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label: 'TextSize.labelSmall + TextWeight.heavy + TextTone.muted',
              text: 'EYEBROW LABEL',
              style: appTextStyle.resolve(tokens, [
                TextSize.labelSmall,
                TextWeight.heavy,
                TextTone.muted,
              ]),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label:
                  'TextSize.bodyLarge + TextWeight.strong + TextTone.primary',
              text: '図書館 (Library)',
              style: appTextStyle.resolve(tokens, [
                TextSize.bodyLarge,
                TextWeight.strong,
                TextTone.primary,
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonLabSection extends StatelessWidget {
  const _ButtonLabSection();

  @override
  Widget build(BuildContext context) {
    return DesignSection(
      title: '05. The Button Lab',
      child: _ResponsiveGrid(
        minItemWidth: 320,
        children: [
          _ButtonGroup(
            title: 'Tone',
            children: [
              TactileButton(
                tone: TactileTone.filled,
                leading: Icon(Icons.play_arrow),
                onPressed: () {},
                child: Text('Filled'),
              ),
              TactileButton(
                tone: TactileTone.ghost,
                leading: Icon(Icons.layers_outlined),
                onPressed: () {},
                child: Text('Ghost'),
              ),
              TactileButton(
                tone: TactileTone.text,
                leading: Icon(Icons.link),
                onPressed: () {},
                child: Text('Text'),
              ),
              TactileButton(
                tone: TactileTone.dashed,
                leading: Icon(Icons.add),
                onPressed: () {},
                child: Text('Dashed'),
              ),
              TactileButton(
                tone: TactileTone.streak,
                leading: Icon(Icons.local_fire_department),
                onPressed: () {},
                child: Text('Streak'),
              ),
            ],
          ),
          _ButtonGroup(
            title: 'Rating',
            children: [
              TactileButton(
                tone: TactileTone.again,
                leading: Icon(Icons.replay),
                onPressed: () {},
                child: Text('Again'),
              ),
              TactileButton(
                tone: TactileTone.hard,
                leading: Icon(Icons.priority_high),
                onPressed: () {},
                child: Text('Hard'),
              ),
              TactileButton(
                tone: TactileTone.good,
                leading: Icon(Icons.check),
                onPressed: () {},
                child: Text('Good'),
              ),
              TactileButton(
                tone: TactileTone.easy,
                leading: Icon(Icons.bolt),
                onPressed: () {},
                child: Text('Easy'),
              ),
            ],
          ),
          _ButtonGroup(
            title: 'State',
            children: [
              TactileButton(
                tone: TactileTone.success,
                leading: Icon(Icons.check_circle),
                onPressed: () {},
                child: Text('Success'),
              ),
              TactileButton(
                tone: TactileTone.error,
                leading: Icon(Icons.cancel),
                onPressed: () {},
                child: Text('Error'),
              ),
              TactileButton(
                selected: true,
                leading: Icon(Icons.star),
                onPressed: () {},
                child: Text('Selected'),
              ),
              TactileButton(
                leading: Icon(Icons.block),
                child: Text('Disabled'),
              ),
            ],
          ),
          _ButtonGroup(
            title: 'Size',
            children: [
              TactileButton(
                size: TactileSize.sm,
                leading: Icon(Icons.text_fields),
                onPressed: () {},
                child: Text('Small'),
              ),
              TactileButton(
                size: TactileSize.md,
                leading: Icon(Icons.text_fields),
                onPressed: () {},
                child: Text('Medium'),
              ),
              TactileButton(
                size: TactileSize.lg,
                leading: Icon(Icons.text_fields),
                onPressed: () {},
                child: Text('Large'),
              ),
              TactileButton.icon(icon: Icons.settings, onPressed: () {}),
            ],
          ),
          _ButtonGroup(
            title: 'Alignment',
            children: [
              SizedBox(
                width: double.infinity,
                child: TactileButton(
                  mainAxisAlignment: MainAxisAlignment.start,
                  leading: Icon(Icons.format_align_left),
                  onPressed: () {},
                  child: Text('Start aligned'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: TactileButton(
                  mainAxisAlignment: MainAxisAlignment.center,
                  leading: Icon(Icons.format_align_center),
                  onPressed: () {},
                  child: Text('Center aligned'),
                ),
              ),
              TactileButton(
                leading: Icon(Icons.fit_screen),
                onPressed: () {},
                child: Text('Fit content'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SurfaceSection extends StatelessWidget {
  const _SurfaceSection();

  @override
  Widget build(BuildContext context) {
    return DesignSection(
      title: '04. Surface Variants',
      child: _ResponsiveGrid(
        minItemWidth: 300,
        children: const [
          _SurfaceSample(
            title: 'Surface',
            tone: SurfaceTone.surface,
            description: 'Default panel surface.',
          ),
          _SurfaceSample(
            title: 'Primary Outline',
            tone: SurfaceTone.primaryOutline,
            description: 'White card with primary outline.',
          ),
          _SurfaceSample(
            title: 'Muted',
            tone: SurfaceTone.muted,
            description: 'Soft inset grouping surface.',
          ),
          _SurfaceSample(
            title: 'Dark',
            tone: SurfaceTone.dark,
            description: 'High-emphasis dark surface.',
            dark: true,
          ),
        ],
      ),
    );
  }
}

class _SurfaceSample extends StatelessWidget {
  const _SurfaceSample({
    required this.title,
    required this.tone,
    required this.description,
    this.dark = false,
  });

  final String title;
  final SurfaceTone tone;
  final String description;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final titleColor = dark ? tokens.colorTextOnBrand : tokens.textPrimary;
    final bodyColor = dark
        ? tokens.colorTextOnBrand.withValues(alpha: 0.78)
        : tokens.textSecondary;

    return Surface(
      style: surfaceStyle.resolve(tokens, [tone]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: appTextStyle
                .resolve(tokens, [
                  TextSize.labelLarge,
                  TextWeight.heavy,
                  TextTone.primary,
                ])
                .copyWith(color: titleColor),
          ),
          const SizedBox(height: 10),
          Text(
            'SurfaceTone.$tone'.replaceFirst('SurfaceTone.', ''),
            style: appTextStyle
                .resolve(tokens, [
                  TextSize.labelSmall,
                  TextWeight.heavy,
                  TextTone.muted,
                ])
                .copyWith(color: bodyColor),
          ),
          const SizedBox(height: 14),
          Text(
            description,
            style: appTextStyle
                .resolve(tokens, [
                  TextSize.label,
                  TextWeight.body,
                  TextTone.secondary,
                ])
                .copyWith(color: bodyColor),
          ),
        ],
      ),
    );
  }
}

class _RoadmapSection extends StatelessWidget {
  const _RoadmapSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final items = [
      (
        Icons.vibration,
        'Haptic Engine',
        'Every tactile button should trigger a native vibration pattern.',
      ),
      (
        Icons.contrast,
        'Sensory Safety',
        'Add a Soft Mode toggle that reduces contrast and motion.',
      ),
      (
        Icons.text_fields,
        'Dyslexia Support',
        'Include a toggle for OpenDyslexic or a similar typeface.',
      ),
    ];

    return DesignSection(
      title: '07. Accessibility & Flutter Roadmap',
      child: Surface(
        style: surfaceStyle.resolve(tokens, const [SurfaceTone.dark]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Device Level Integrations',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.$1, color: tokens.colorTextOnBrand, size: 22),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: '${item.$2}: ',
                          style: const TextStyle(fontWeight: FontWeight.w900),
                          children: [
                            TextSpan(
                              text: item.$3,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        style: TextStyle(
                          color: tokens.colorTextOnBrand,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.icon,
    required this.title,
    required this.body,
    required this.tone,
  });

  final IconData icon;
  final String title;
  final String body;
  final TactileTone tone;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final color = switch (tone) {
      TactileTone.ghost => tokens.primary,
      TactileTone.streak => tokens.streak,
      TactileTone.success => tokens.actionSuccess,
      _ => tokens.primary,
    };

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(height: 22),
          Text(
            title,
            style: appTextStyle
                .resolve(tokens, [
                  TextSize.labelLarge,
                  TextWeight.heavy,
                  TextTone.primary,
                ])
                .copyWith(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            body,
            style: appTextStyle.resolve(tokens, [
              TextSize.label,
              TextWeight.body,
              TextTone.secondary,
            ]),
          ),
        ],
      ),
    );
  }
}

class _ResponsiveGrid extends StatelessWidget {
  const _ResponsiveGrid({required this.children, required this.minItemWidth});

  final List<Widget> children;
  final double minItemWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = (constraints.maxWidth / minItemWidth).floor().clamp(
          1,
          children.length,
        );
        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: [
            for (final child in children)
              SizedBox(
                width: (constraints.maxWidth - (24 * (columns - 1))) / columns,
                child: child,
              ),
          ],
        );
      },
    );
  }
}

class _TokenSwatch {
  const _TokenSwatch(this.name, this.color);

  final String name;
  final Color color;
}

class _TokenSwatchGroup extends StatelessWidget {
  const _TokenSwatchGroup({required this.title, required this.swatches});

  final String title;
  final List<_TokenSwatch> swatches;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: appTextStyle.resolve(tokens, [
            TextSize.labelSmall,
            TextWeight.heavy,
            TextTone.muted,
          ]),
        ),
        const SizedBox(height: 14),
        _ResponsiveGrid(
          minItemWidth: 170,
          children: [
            for (final swatch in swatches) _TokenSwatchCard(swatch: swatch),
          ],
        ),
      ],
    );
  }
}

class _TokenSwatchCard extends StatelessWidget {
  const _TokenSwatchCard({required this.swatch});

  final _TokenSwatch swatch;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final hex =
        '#${swatch.color.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 96,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: swatch.color,
            borderRadius: BorderRadius.circular(tokens.radius3xl),
            border: Border.all(
              color: tokens.borderNeutralSubtle,
              width: tokens.borderWidthDefault,
            ),
            boxShadow: [
              BoxShadow(
                color: tokens.borderNeutralSubtle.withValues(alpha: 0.55),
                offset: const Offset(0, 3),
                blurRadius: 10,
              ),
            ],
          ),
          child: Text(
            hex,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          swatch.name,
          style: appTextStyle.resolve(tokens, [
            TextSize.label,
            TextWeight.strong,
            TextTone.primary,
          ]),
        ),
        const SizedBox(height: 2),
        Text(
          hex,
          style: appTextStyle.resolve(tokens, [
            TextSize.labelSmall,
            TextWeight.body,
            TextTone.muted,
          ]),
        ),
      ],
    );
  }
}

class _TypeSpec extends StatelessWidget {
  const _TypeSpec({
    required this.label,
    required this.text,
    required this.style,
  });

  final String label;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: appTextStyle.resolve(tokens, [
            TextSize.labelSmall,
            TextWeight.heavy,
            TextTone.muted,
          ]),
        ),
        const SizedBox(height: 8),
        Text(text, style: style),
      ],
    );
  }
}

class _ButtonGroup extends StatelessWidget {
  const _ButtonGroup({required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: appTextStyle.resolve(tokens, [
            TextSize.labelSmall,
            TextWeight.heavy,
            TextTone.muted,
          ]),
        ),
        const SizedBox(height: 18),
        Wrap(spacing: 14, runSpacing: 14, children: children),
      ],
    );
  }
}
