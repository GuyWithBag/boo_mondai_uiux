import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../theme/app_variant_styles.dart';
import '../widgets/app_panel.dart';
import '../widgets/design_section.dart';
import '../widgets/editor_card.dart';
import '../widgets/tactile_button.dart';

enum FormatType { normal, mcq, blanks, match }

enum DirectionType { normal, reverse, both }

class CreatorStudioPage extends HookWidget {
  const CreatorStudioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final format = useState(FormatType.normal);
    final direction = useState(DirectionType.normal);
    final tokens = context.themeTokens<AppTokens>();
    final directionHint = switch (direction.value) {
      DirectionType.both =>
        'Generates 2 Notes: Front to Back and Back to Front.',
      DirectionType.reverse => 'Generates 1 Note: Back to Front.',
      DirectionType.normal => 'Generates 1 Note: Front to Back.',
    };

    return Scaffold(
      backgroundColor: tokens.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            _StudioHeader(tokens: tokens),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final showSidebar = constraints.maxWidth >= 860.w;
                  return Row(
                    children: [
                      if (showSidebar) const _CardSidebar(),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(32.w),
                          child: Center(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 960.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  _FormatSelector(
                                    selected: format.value,
                                    onChanged: (value) => format.value = value,
                                  ),
                                  if (format.value == FormatType.normal) ...[
                                    SizedBox(height: 28.h),
                                    _DirectionSelector(
                                      selected: direction.value,
                                      hint: directionHint,
                                      onChanged: (value) =>
                                          direction.value = value,
                                    ),
                                  ],
                                  SizedBox(height: 42.h),
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 220),
                                    child: _EditorBody(
                                      format: format.value,
                                      key: ValueKey(format.value),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudioHeader extends HookWidget {
  const _StudioHeader({required this.tokens});

  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    final titleController = useTextEditingController(text: 'JLPT N5 Grammar');

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: tokens.backgroundSurface,
        border: Border(
          bottom: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
        ),
      ),
      child: Row(
        children: [
          TactileButton(
            icon: Icons.arrow_back,
            size: TactileSize.icon,
            onPressed: () => context.go('/'),
            child: const SizedBox.shrink(),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: tokens.indigoSoft,
                        borderRadius: BorderRadius.circular(7.r),
                        border: Border.all(
                          color: tokens.primaryLight,
                          width: 2,
                        ),
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
          SizedBox(width: 16.w),
          TactileButton(
            tone: TactileTone.text,
            icon: Icons.settings,
            onPressed: () => context.go('/design-system'),
            child: const Text('Settings'),
          ),
          SizedBox(width: 12.w),
          TactileButton(
            tone: TactileTone.primary,
            onPressed: () {},
            child: const Text('Save & Close'),
          ),
        ],
      ),
    );
  }
}

class _CardSidebar extends StatelessWidget {
  const _CardSidebar();

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
                const TactileButton(
                  icon: Icons.add,
                  size: TactileSize.icon,
                  child: SizedBox.shrink(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.w),
              children: const [
                _CardListTile(
                  selected: true,
                  icon: Icons.slideshow_outlined,
                  title: '勉強 (benkyou)',
                ),
                SizedBox(height: 12),
                _CardListTile(icon: Icons.list, title: 'Which particle is...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardListTile extends StatelessWidget {
  const _CardListTile({
    required this.icon,
    required this.title,
    this.selected = false,
  });

  final IconData icon;
  final String title;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final color = selected ? tokens.primary : tokens.textSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: selected
          ? tactileButtonDecoration.resolve(tokens, const [TactileTone.ghost])
          : BoxDecoration(
              color: tokens.backgroundSurface,
              borderRadius: BorderRadius.circular(tokens.radius2xl),
              border: Border.all(color: Colors.transparent, width: 2),
            ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FormatSelector extends StatelessWidget {
  const _FormatSelector({required this.selected, required this.onChanged});

  final FormatType selected;
  final ValueChanged<FormatType> onChanged;

  @override
  Widget build(BuildContext context) {
    final formats = [
      (FormatType.normal, Icons.slideshow_outlined, 'Flashcard'),
      (FormatType.mcq, Icons.list, 'Multiple Choice'),
      (FormatType.blanks, Icons.draw, 'Fill in Blanks'),
      (FormatType.match, Icons.shuffle, 'Match Madness'),
    ];

    return DesignSection(
      title: '01. Question Format',
      margin: EdgeInsets.zero,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final item in formats) ...[
              TactileButton(
                icon: item.$2,
                selected: selected == item.$1,
                tone: selected == item.$1
                    ? TactileTone.ghost
                    : TactileTone.secondary,
                onPressed: () => onChanged(item.$1),
                child: Text(item.$3),
              ),
              const SizedBox(width: 14),
            ],
          ],
        ),
      ),
    );
  }
}

class _DirectionSelector extends StatelessWidget {
  const _DirectionSelector({
    required this.selected,
    required this.hint,
    required this.onChanged,
  });

  final DirectionType selected;
  final String hint;
  final ValueChanged<DirectionType> onChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final options = [
      (DirectionType.normal, 'Normal'),
      (DirectionType.reverse, 'Reversed'),
      (DirectionType.both, 'Both Ways'),
    ];

    return AppPanel(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        spacing: 18,
        runSpacing: 18,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 310,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Study Direction',
                  style: appTextStyle
                      .resolve(tokens, [AppTextRole.title])
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(height: 6),
                Text(
                  hint,
                  style: appTextStyle.resolve(tokens, [AppTextRole.body]),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: tokens.softGray,
              borderRadius: BorderRadius.circular(tokens.radius3xl),
            ),
            child: Wrap(
              spacing: 8,
              children: [
                for (final option in options)
                  _SegmentButton(
                    label: option.$2,
                    selected: selected == option.$1,
                    onTap: () => onChanged(option.$1),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return InkWell(
      borderRadius: BorderRadius.circular(tokens.radius2xl),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? tokens.backgroundSurface : Colors.transparent,
          borderRadius: BorderRadius.circular(tokens.radius2xl),
          border: Border.all(
            color: selected ? tokens.borderNeutralSubtle : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? tokens.textPrimary : tokens.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

class _EditorBody extends StatelessWidget {
  const _EditorBody({required this.format, super.key});

  final FormatType format;

  @override
  Widget build(BuildContext context) {
    return switch (format) {
      FormatType.normal => const _FlashcardEditor(),
      FormatType.mcq => const _McqEditor(),
      FormatType.blanks => const _BlanksEditor(),
      FormatType.match => const _MatchEditor(),
    };
  }
}

class _FlashcardEditor extends StatelessWidget {
  const _FlashcardEditor();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveTwoColumn(
      children: [
        EditorCard(title: 'Front (Prompt)', placeholder: 'Type a word...'),
        EditorCard(
          title: 'Back (Answer)',
          placeholder: 'Type the translation...',
        ),
      ],
    );
  }
}

class _McqEditor extends StatelessWidget {
  const _McqEditor();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveTwoColumn(
      children: [
        EditorCard(title: 'Front (Prompt)', placeholder: 'Type a question...'),
        _McqOptionsPanel(),
      ],
    );
  }
}

class _McqOptionsPanel extends StatelessWidget {
  const _McqOptionsPanel();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return AppPanel(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Answer Options'.toUpperCase(),
                  style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: tokens.indigoSoft,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tokens.primaryLight),
                ),
                child: Text(
                  'Select correct',
                  style: TextStyle(
                    color: tokens.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _McqOption(correct: true, value: 'To study'),
          const SizedBox(height: 14),
          const _McqOption(value: 'To eat'),
          const Spacer(),
          const SizedBox(height: 20),
          TactileButton(
            icon: Icons.add,
            tone: TactileTone.ghost,
            expand: true,
            onPressed: () {},
            child: const Text('Add Option'),
          ),
        ],
      ),
    );
  }
}

class _McqOption extends HookWidget {
  const _McqOption({required this.value, this.correct = false});

  final String value;
  final bool correct;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = useTextEditingController(text: value);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: correct
          ? tactileButtonDecoration.resolve(tokens, const [TactileTone.success])
          : tactileButtonDecoration.resolve(tokens),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: correct
                    ? tokens.actionSuccess
                    : tokens.borderNeutralSubtle,
                width: 3,
              ),
            ),
            child: correct
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: tokens.actionSuccess,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                : null,
          ),
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(
                color: tokens.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              decoration: const InputDecoration.collapsed(hintText: ''),
            ),
          ),
          IconButton(
            color: tokens.textMuted,
            onPressed: () {},
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class _BlanksEditor extends StatelessWidget {
  const _BlanksEditor();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return AppPanel(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sentence Builder'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          const SizedBox(height: 14),
          Text(
            'Type your full sentence below. Highlight the words you want the user to guess, and click "Create Blank".',
            style: appTextStyle
                .resolve(tokens, [AppTextRole.body])
                .copyWith(fontSize: 17),
          ),
          const SizedBox(height: 28),
          AppPanel(
            tone: PanelTone.muted,
            radius: 24,
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '私は毎日',
                      style: TextStyle(
                        color: tokens.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.6,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: tactileButtonDecoration
                          .resolve(tokens, const [TactileTone.primary])
                          .copyWith(
                            borderRadius: BorderRadius.circular(
                              tokens.radiusXl,
                            ),
                          ),
                      child: const Text(
                        '図書館',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Text(
                      'で勉強します。',
                      style: TextStyle(
                        color: tokens.textPrimary,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        height: 1.6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Align(
                  alignment: Alignment.centerRight,
                  child: TactileButton(
                    icon: Icons.cleaning_services,
                    onPressed: () {},
                    child: const Text('Create Blank'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 36),
          Text(
            'Hidden Segments'.toUpperCase(),
            style: TextStyle(
              color: tokens.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 14),
          AppPanel(
            tone: PanelTone.muted,
            radius: 24,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: tactileButtonDecoration.resolve(tokens, const [
                    TactileTone.ghost,
                  ]),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: tokens.primary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct Answer'.toUpperCase(),
                        style: appTextStyle.resolve(tokens, [
                          AppTextRole.eyebrow,
                        ]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '図書館 (Library)',
                        style: TextStyle(
                          color: tokens.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: tokens.actionError),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchEditor extends StatelessWidget {
  const _MatchEditor();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return AppPanel(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Matching Pairs'.toUpperCase(),
            style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 44),
              Expanded(
                child: Text(
                  'TERM',
                  style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
                ),
              ),
              const SizedBox(width: 56),
              Expanded(
                child: Text(
                  'MATCH',
                  style: appTextStyle.resolve(tokens, [AppTextRole.eyebrow]),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
          const SizedBox(height: 12),
          const _MatchPair(term: '犬', match: 'Dog'),
          const SizedBox(height: 14),
          const _MatchPair(term: '猫', match: 'Cat'),
          const SizedBox(height: 28),
          TactileButton(
            icon: Icons.add,
            tone: TactileTone.ghost,
            expand: true,
            onPressed: () {},
            child: const Text('Add Pair'),
          ),
        ],
      ),
    );
  }
}

class _MatchPair extends StatelessWidget {
  const _MatchPair({required this.term, required this.match});

  final String term;
  final String match;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Row(
      children: [
        Icon(Icons.drag_indicator, color: tokens.textMuted),
        const SizedBox(width: 12),
        Expanded(child: _MatchInput(value: term)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(Icons.compare_arrows, color: tokens.textMuted),
        ),
        Expanded(child: _MatchInput(value: match)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: tokens.textMuted),
        ),
      ],
    );
  }
}

class _MatchInput extends HookWidget {
  const _MatchInput({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = useTextEditingController(text: value);

    return TextField(
      controller: controller,
      style: TextStyle(
        color: tokens.textPrimary,
        fontSize: 24,
        fontWeight: FontWeight.w900,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: tokens.backgroundPage,
        contentPadding: const EdgeInsets.all(16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius2xl),
          borderSide: BorderSide(color: tokens.borderNeutralSubtle, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(tokens.radius2xl),
          borderSide: BorderSide(color: tokens.primary, width: 2),
        ),
      ),
    );
  }
}

class _ResponsiveTwoColumn extends StatelessWidget {
  const _ResponsiveTwoColumn({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 760) {
          return Column(
            children: [
              for (final child in children) ...[
                SizedBox(height: 350, child: child),
                if (child != children.last) const SizedBox(height: 24),
              ],
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final child in children) ...[
              Expanded(child: SizedBox(height: 350, child: child)),
              if (child != children.last) const SizedBox(width: 28),
            ],
          ],
        );
      },
    );
  }
}
