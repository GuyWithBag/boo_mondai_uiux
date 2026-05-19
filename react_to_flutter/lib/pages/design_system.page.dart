import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:react_to_flutter/widgets/design_section.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';
import '../widgets/color_bubble.dart';
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
                      const _ButtonLabSection(),
                      const _ProgressPathwaySection(),
                      const _HeroTransitionSection(),
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
            child: TactileButton(
              icon: Icons.close,
              size: TactileSize.icon,
              onPressed: () => context.go('/'),
              child: const SizedBox.shrink(),
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
      child: _ResponsiveGrid(
        minItemWidth: 170,
        children: [
          ColorBubble(color: tokens.primary, hex: '#6366F1', label: 'Primary'),
          ColorBubble(color: tokens.streak, hex: '#F97316', label: 'Streak'),
          ColorBubble(
            color: tokens.backgroundPage,
            hex: '#F8F9FA',
            label: 'Soft Background',
          ),
          ColorBubble(
            color: tokens.actionSuccess,
            hex: '#22C55E',
            label: 'Mastery/Success',
          ),
          ColorBubble(
            color: tokens.actionError,
            hex: '#EF4444',
            label: 'Review/Error',
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
              label: 'Display 01 / Black',
              text: 'Learning Made Tactile',
              style: appTextStyle
                  .resolve(tokens, [AppTextRole.display])
                  .copyWith(fontSize: 54),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label: 'Header 02 / ExtraBold',
              text: 'Ready for your review?',
              style: appTextStyle
                  .resolve(tokens, [AppTextRole.title])
                  .copyWith(fontSize: 30),
            ),
            const SizedBox(height: 30),
            _TypeSpec(
              label: 'Body / Medium',
              text:
                  'The quick brown flashcard. We prioritize readability with high line-height and generous spacing.',
              style: appTextStyle
                  .resolve(tokens, [AppTextRole.body])
                  .copyWith(fontSize: 20),
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
      title: '04. The Button Lab',
      child: _ResponsiveGrid(
        minItemWidth: 360,
        children: const [
          _ButtonGroup(
            title: 'Action Variants',
            children: [
              TactileButton(
                tone: TactileTone.primary,
                size: TactileSize.lg,
                child: Text('Primary Action'),
              ),
              TactileButton(size: TactileSize.lg, child: Text('Secondary')),
              TactileButton(
                tone: TactileTone.ghost,
                child: Text('Ghost Variant'),
              ),
              TactileButton(tone: TactileTone.text, child: Text('Text Link')),
            ],
          ),
          _ButtonGroup(
            title: 'Memory Rating',
            children: [
              TactileButton(
                tone: TactileTone.error,
                expand: true,
                child: _RatingText(label: 'Again', interval: '1M'),
              ),
              TactileButton(
                tone: TactileTone.success,
                expand: true,
                child: _RatingText(label: 'Good', interval: '10M'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressPathwaySection extends StatelessWidget {
  const _ProgressPathwaySection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return DesignSection(
      title: '05. Progress Pathways',
      child: Surface(
        style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                'Abstract percentage bars are difficult to contextualize. By transforming progress into a physical pathway, learning becomes a tangible journey.',
                textAlign: TextAlign.center,
                style: appTextStyle.resolve(tokens, [AppTextRole.body]),
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              height: 116,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 12,
                    decoration: BoxDecoration(
                      color: tokens.softGray,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.5,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: tokens.primary,
                        borderRadius: BorderRadius.circular(99),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      _PathNode(icon: Icons.check, active: true),
                      _PathNode(icon: Icons.check, active: true),
                      _PathNode(
                        icon: Icons.local_fire_department,
                        current: true,
                      ),
                      _PathNode(icon: Icons.lock, active: false),
                      _PathNode(icon: Icons.lock, active: false),
                    ],
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

class _HeroTransitionSection extends StatelessWidget {
  const _HeroTransitionSection();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return DesignSection(
      title: '06. Spatial Navigation',
      child: Surface(
        style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
        child: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Text(
                'Hero animations anchor spatial awareness by physically morphing the clicked element into the next screen header.',
                textAlign: TextAlign.center,
                style: appTextStyle.resolve(tokens, [AppTextRole.body]),
              ),
            ),
            const SizedBox(height: 36),
            _ResponsiveGrid(
              minItemWidth: 280,
              children: const [
                _TransitionStateOne(),
                Center(child: Icon(Icons.arrow_forward, size: 36)),
                _TransitionStateTwo(),
              ],
            ),
          ],
        ),
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
      'Haptic Engine: Every 3D button should trigger a native vibration pattern.',
      'Sensory Safety: Add a Soft Mode toggle that reduces contrast and motion.',
      'Dyslexia Support: Include a toggle for OpenDyslexic or a similar typeface.',
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
                padding: const EdgeInsets.only(bottom: 14),
                child: Text(
                  item,
                  style: TextStyle(
                    color: tokens.primaryLight,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    height: 1.4,
                  ),
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
                .resolve(tokens, [AppTextRole.title])
                .copyWith(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(body, style: appTextStyle.resolve(tokens, [AppTextRole.body])),
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
          style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
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
          style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
        ),
        const SizedBox(height: 18),
        Wrap(spacing: 14, runSpacing: 14, children: children),
      ],
    );
  }
}

class _RatingText extends StatelessWidget {
  const _RatingText({required this.label, required this.interval});

  final String label;
  final String interval;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
        ),
        Text(
          interval,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _PathNode extends StatelessWidget {
  const _PathNode({
    required this.icon,
    this.active = false,
    this.current = false,
  });

  final IconData icon;
  final bool active;
  final bool current;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final size = current ? 78.0 : 56.0;
    final color = current
        ? tokens.streak
        : (active ? tokens.primary : const Color(0xffe5e7eb));
    final shadow = current
        ? tokens.streakDark
        : (active ? tokens.primaryDark : Colors.transparent);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(color: shadow, offset: Offset(0, current ? 6 : 4)),
        ],
      ),
      child: Icon(
        icon,
        color: active || current ? Colors.white : tokens.textMuted,
      ),
    );
  }
}

class _TransitionStateOne extends StatelessWidget {
  const _TransitionStateOne();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.muted]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'State 1: Deck List'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          const SizedBox(height: 16),
          Container(
            height: 128,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tokens.primaryLight.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(tokens.radius2xl),
              border: Border.all(color: tokens.primary, width: 2),
            ),
            child: Text(
              'JLPT N5 Core',
              style: TextStyle(
                color: tokens.primary,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransitionStateTwo extends StatelessWidget {
  const _TransitionStateTwo();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        children: [
          Text(
            'State 2: Study Session'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          const SizedBox(height: 16),
          Container(
            height: 160,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tokens.primary,
              borderRadius: BorderRadius.circular(tokens.radius2xl),
            ),
            child: const Text(
              'JLPT N5 Core\nStudy Session Active',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
