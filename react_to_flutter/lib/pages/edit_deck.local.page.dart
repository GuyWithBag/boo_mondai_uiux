import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:react_to_flutter/widgets/text_field_card.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';
import '../widgets/segmented_control.dart';
import '../widgets/tactile_button.dart';

enum FormatType { normal, mcq, blanks, match }

enum DirectionType { normal, reverse, both }

class EditDeckPage extends HookWidget {
  const EditDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(
      initialLength: FormatType.values.length,
    );
    final pageController = usePageController(initialPage: tabController.index);
    final selectedFormatIndex = useState(tabController.index);
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
                      if (showSidebar) const EditDeckSidebar(),
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
                                    selectedIndex: selectedFormatIndex.value,
                                    onChanged: (index) {
                                      selectedFormatIndex.value = index;
                                      tabController.animateTo(index);
                                      pageController.animateToPage(
                                        index,
                                        duration: const Duration(
                                          milliseconds: 220,
                                        ),
                                        curve: Curves.easeOutCubic,
                                      );
                                    },
                                  ),
                                  if (selectedFormatIndex.value == 0) ...[
                                    SizedBox(height: 28.h),
                                    _DirectionSelector(
                                      selected: direction.value,
                                      hint: directionHint,
                                      onChanged: (value) =>
                                          direction.value = value,
                                    ),
                                  ],
                                  SizedBox(height: 42.h),
                                  SizedBox(
                                    height: 760.h,
                                    child: PageView(
                                      controller: pageController,
                                      onPageChanged: (index) {
                                        selectedFormatIndex.value = index;
                                        tabController.animateTo(index);
                                      },
                                      children: const [
                                        FlashcardEditor(),
                                        MultipleChoiceEditor(),
                                        FillInTheBlanks(),
                                        MatchingTypeEditor(),
                                      ],
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

class EditDeckSidebar extends StatelessWidget {
  const EditDeckSidebar();

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
                TactileButton(
                  onPressed: () {},
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
              children: [
                TactileButton(
                  selected: true,
                  onPressed: () {},
                  icon: Icons.slideshow_outlined,
                  textAlign: TextAlign.left,
                  tone: TactileTone.ghost,
                  child: Text('勉強 (benkyou)'),
                ),
                SizedBox(height: 12),
                TactileButton(
                  icon: Icons.list,
                  onPressed: () {},
                  textAlign: TextAlign.left,
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

class _FormatSelector extends StatelessWidget {
  const _FormatSelector({required this.selectedIndex, required this.onChanged});

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final formats = [
      (Icons.slideshow_outlined, 'Flashcard'),
      (Icons.list, 'Multiple Choice'),
      (Icons.draw, 'Fill in Blanks'),
      (Icons.shuffle, 'Match Madness'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var index = 0; index < formats.length; index++) ...[
            TactileButton(
              icon: formats[index].$1,
              selected: selectedIndex == index,
              tone: selectedIndex == index
                  ? TactileTone.ghost
                  : TactileTone.secondary,
              onPressed: () => onChanged(index),
              child: Text(formats[index].$2),
            ),
            const SizedBox(width: 14),
          ],
        ],
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
    const options = [
      SegmentOption(value: DirectionType.normal, label: 'Normal'),
      SegmentOption(value: DirectionType.reverse, label: 'Reversed'),
      SegmentOption(value: DirectionType.both, label: 'Both Ways'),
    ];

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
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
          SegmentedControl<DirectionType>(
            options: options,
            value: selected,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class FlashcardEditor extends StatelessWidget {
  const FlashcardEditor();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveTwoColumn(
      children: [
        TextFieldCard(title: 'Front (Prompt)', placeholder: 'Type a word...'),
        TextFieldCard(
          title: 'Back (Answer)',
          placeholder: 'Type the translation...',
        ),
      ],
    );
  }
}

class MultipleChoiceEditor extends StatelessWidget {
  const MultipleChoiceEditor();

  @override
  Widget build(BuildContext context) {
    return const _ResponsiveTwoColumn(
      children: [
        TextFieldCard(
          title: 'Front (Prompt)',
          placeholder: 'Type a question...',
        ),
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

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
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
          const MultipleChoiceOption(correct: true, value: 'To study'),
          const SizedBox(height: 14),
          const MultipleChoiceOption(value: 'To eat'),
          const Spacer(),
          const SizedBox(height: 20),
          TactileButton(
            icon: Icons.add,
            tone: TactileTone.dashed,
            expand: true,
            onPressed: () {},
            child: const Text('Add Option'),
          ),
        ],
      ),
    );
  }
}

class MultipleChoiceOption extends HookWidget {
  const MultipleChoiceOption({required this.value, this.correct = false});

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

class FillInTheBlanks extends StatelessWidget {
  const FillInTheBlanks();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
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
          Surface(
            style: surfaceStyle.resolve(tokens, const [SurfaceTone.muted]),
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
          Surface(
            style: surfaceStyle.resolve(tokens, const [SurfaceTone.muted]),
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

class MatchingTypeEditor extends StatelessWidget {
  const MatchingTypeEditor();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
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
            tone: TactileTone.dashed,
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
        Expanded(child: MatchingTypeInput(value: term)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Icon(Icons.compare_arrows, color: tokens.textMuted),
        ),
        Expanded(child: MatchingTypeInput(value: match)),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.delete, color: tokens.textMuted),
        ),
      ],
    );
  }
}

class MatchingTypeInput extends HookWidget {
  const MatchingTypeInput({required this.value});

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
