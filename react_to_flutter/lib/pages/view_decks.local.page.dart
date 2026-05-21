import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../variant_styles/variant_styles.barrel.dart';
import '../widgets/tactile_button.dart';
import '../widgets/variant_text_field.dart';

enum DeckSortOption { alphabet, latest, oldest, leastUsed, mostUsed }

enum DeckSortDirection { ascending, descending }

class ViewDecksLocalPage extends HookWidget {
  const ViewDecksLocalPage({super.key});

  static const _deckTags = ['JLPT', 'Grammar', 'Vocabulary', 'Daily'];
  static const _cardTemplateTags = ['Flashcard', 'MCQ', 'Fill Blank', 'Match'];
  static const _reviewCardTags = ['Due Today', 'New', 'Leech', 'Mastered'];
  static final _decks = [
    _DeckPreview(
      title: 'JLPT N5 Core',
      description: 'Essential grammar, particles, and daily vocabulary.',
      cardCount: 128,
      lastUpdated: DateTime(2026, 5, 18),
      usedCount: 42,
      deckTags: {'JLPT', 'Grammar'},
      cardTemplateTags: {'Flashcard', 'MCQ'},
      reviewCardTags: {'Due Today', 'New'},
    ),
    _DeckPreview(
      title: 'Travel Japanese',
      description: 'Phrases for stations, restaurants, and quick questions.',
      cardCount: 76,
      lastUpdated: DateTime(2026, 5, 7),
      usedCount: 18,
      deckTags: {'Daily', 'Vocabulary'},
      cardTemplateTags: {'Flashcard', 'Fill Blank'},
      reviewCardTags: {'Mastered'},
    ),
    _DeckPreview(
      title: 'Particle Practice',
      description: 'Focused drills for は, が, を, に, and で.',
      cardCount: 54,
      lastUpdated: DateTime(2026, 5, 20),
      usedCount: 9,
      deckTags: {'JLPT', 'Grammar'},
      cardTemplateTags: {'MCQ', 'Fill Blank'},
      reviewCardTags: {'Due Today', 'Leech'},
    ),
    _DeckPreview(
      title: 'Kanji Pair Match',
      description: 'Match kanji to readings and compact English meanings.',
      cardCount: 91,
      lastUpdated: DateTime(2026, 4, 29),
      usedCount: 31,
      deckTags: {'Vocabulary'},
      cardTemplateTags: {'Match'},
      reviewCardTags: {'New'},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final searchController = useTextEditingController();
    final searchQuery = useState('');
    final filters = useState(const _DeckFilterState());
    final sortOption = useState(DeckSortOption.alphabet);
    final sortDirection = useState(DeckSortDirection.ascending);

    final visibleDecks = useMemoized(
      () => _filteredAndSortedDecks(
        query: searchQuery.value,
        filters: filters.value,
        sortOption: sortOption.value,
        sortDirection: sortDirection.value,
      ),
      [searchQuery.value, filters.value, sortOption.value, sortDirection.value],
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.w),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1120.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TactileButton.icon(
                        icon: Icons.arrow_back,
                        onPressed: () => context.go('/'),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Text(
                          'Deck Library',
                          style: appTextStyle.resolve(tokens, [
                            TextSize.header,
                            TextWeight.heavy,
                            TextTone.primary,
                          ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  _DeckLibraryToolbar(
                    searchController: searchController,
                    searchQuery: searchQuery.value,
                    onSearchChanged: (value) => searchQuery.value = value,
                    filters: filters.value,
                    onFiltersChanged: (value) => filters.value = value,
                    sortOption: sortOption.value,
                    onSortOptionChanged: (value) => sortOption.value = value,
                    sortDirection: sortDirection.value,
                    onSortDirectionChanged: (value) =>
                        sortDirection.value = value,
                  ),
                  if (filters.value.activeCount > 0) ...[
                    SizedBox(height: 18.h),
                    _ActiveFilterChips(
                      filters: filters.value,
                      onClear: () => filters.value = const _DeckFilterState(),
                    ),
                  ],
                  SizedBox(height: 28.h),
                  _DeckResultSummary(
                    count: visibleDecks.length,
                    total: _decks.length,
                  ),
                  SizedBox(height: 16.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final columns = constraints.maxWidth >= 840.w ? 2 : 1;
                      final width =
                          (constraints.maxWidth - (20.w * (columns - 1))) /
                          columns;

                      return Wrap(
                        spacing: 20.w,
                        runSpacing: 20.h,
                        children: [
                          for (final deck in visibleDecks)
                            SizedBox(width: width, child: _DeckCard(deck)),
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

  static List<_DeckPreview> _filteredAndSortedDecks({
    required String query,
    required _DeckFilterState filters,
    required DeckSortOption sortOption,
    required DeckSortDirection sortDirection,
  }) {
    final normalizedQuery = query.trim().toLowerCase();
    final filtered = _decks.where((deck) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          deck.title.toLowerCase().contains(normalizedQuery) ||
          deck.description.toLowerCase().contains(normalizedQuery);
      final matchesDeckTags = filters.deckTags.isEmpty
          ? true
          : deck.deckTags.any(filters.deckTags.contains);
      final matchesTemplateTags = filters.cardTemplateTags.isEmpty
          ? true
          : deck.cardTemplateTags.any(filters.cardTemplateTags.contains);
      final matchesReviewTags = filters.reviewCardTags.isEmpty
          ? true
          : deck.reviewCardTags.any(filters.reviewCardTags.contains);

      return matchesQuery &&
          matchesDeckTags &&
          matchesTemplateTags &&
          matchesReviewTags;
    }).toList();

    int compare(_DeckPreview a, _DeckPreview b) {
      return switch (sortOption) {
        DeckSortOption.alphabet => a.title.compareTo(b.title),
        DeckSortOption.latest => b.lastUpdated.compareTo(a.lastUpdated),
        DeckSortOption.oldest => a.lastUpdated.compareTo(b.lastUpdated),
        DeckSortOption.leastUsed => a.usedCount.compareTo(b.usedCount),
        DeckSortOption.mostUsed => b.usedCount.compareTo(a.usedCount),
      };
    }

    filtered.sort(compare);
    if (sortDirection == DeckSortDirection.descending) {
      return filtered.reversed.toList();
    }
    return filtered;
  }
}

class _DeckLibraryToolbar extends StatelessWidget {
  const _DeckLibraryToolbar({
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.filters,
    required this.onFiltersChanged,
    required this.sortOption,
    required this.onSortOptionChanged,
    required this.sortDirection,
    required this.onSortDirectionChanged,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final ValueChanged<String> onSearchChanged;
  final _DeckFilterState filters;
  final ValueChanged<_DeckFilterState> onFiltersChanged;
  final DeckSortOption sortOption;
  final ValueChanged<DeckSortOption> onSortOptionChanged;
  final DeckSortDirection sortDirection;
  final ValueChanged<DeckSortDirection> onSortDirectionChanged;

  @override
  Widget build(BuildContext context) {
    return Surface(
      style: surfaceStyle.resolve(context.themeTokens<AppTokens>(), const [
        SurfaceTone.surface,
      ]),
      child: Wrap(
        spacing: 14.w,
        runSpacing: 14.h,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 420.w,
            child: _DeckSearchBar(
              controller: searchController,
              query: searchQuery,
              onChanged: onSearchChanged,
            ),
          ),
          _DeckFilterButton(
            activeCount: filters.activeCount,
            onPressed: () async {
              final nextFilters = await showModalBottomSheet<_DeckFilterState>(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => _DeckFilterSheet(initialFilters: filters),
              );
              if (nextFilters != null) onFiltersChanged(nextFilters);
            },
          ),
          _DeckSortMenu(value: sortOption, onChanged: onSortOptionChanged),
          TactileButton.icon(
            icon: sortDirection == DeckSortDirection.ascending
                ? Icons.arrow_upward
                : Icons.arrow_downward,
            selected: sortDirection == DeckSortDirection.descending,
            onPressed: () {
              onSortDirectionChanged(
                sortDirection == DeckSortDirection.ascending
                    ? DeckSortDirection.descending
                    : DeckSortDirection.ascending,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _DeckSearchBar extends StatelessWidget {
  const _DeckSearchBar({
    required this.controller,
    required this.query,
    required this.onChanged,
  });

  final TextEditingController controller;
  final String query;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VariantTextField(
            controller: controller,
            placeholder: 'Search decks',
            onChanged: onChanged,
            variants: const [
              AppTextFieldSize.labelLarge,
              AppTextFieldFrame.outline,
              AppTextFieldTone.neutral,
            ],
          ),
        ),
        if (query.isNotEmpty) ...[
          SizedBox(width: 10.w),
          TactileButton.icon(
            icon: Icons.close,
            tone: TactileTone.text,
            onPressed: () {
              controller.clear();
              onChanged('');
            },
          ),
        ],
      ],
    );
  }
}

class _DeckFilterButton extends StatelessWidget {
  const _DeckFilterButton({required this.activeCount, required this.onPressed});

  final int activeCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      tone: activeCount > 0 ? TactileTone.filled : TactileTone.ghost,
      leading: const Icon(Icons.tune),
      trailing: activeCount > 0 ? _FilterCountBadge(activeCount) : null,
      onPressed: onPressed,
      child: const Text('Filters'),
    );
  }
}

class _DeckSortMenu extends StatelessWidget {
  const _DeckSortMenu({required this.value, required this.onChanged});

  final DeckSortOption value;
  final ValueChanged<DeckSortOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<DeckSortOption>(
      tooltip: 'Sort by',
      initialValue: value,
      onSelected: onChanged,
      itemBuilder: (context) => [
        for (final option in DeckSortOption.values)
          PopupMenuItem(value: option, child: Text(option.label)),
      ],
      child: IgnorePointer(
        child: TactileButton(
          leading: const Icon(Icons.sort),
          trailing: const Icon(Icons.keyboard_arrow_down),
          onPressed: () {},
          child: Text(value.label),
        ),
      ),
    );
  }
}

class _DeckFilterSheet extends HookWidget {
  const _DeckFilterSheet({required this.initialFilters});

  final _DeckFilterState initialFilters;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final draft = useState(initialFilters);

    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        bottom: MediaQuery.viewInsetsOf(context).bottom + 16.h,
      ),
      child: Surface(
        style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 620.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Filters',
                        style: appTextStyle.resolve(tokens, [
                          TextSize.header,
                          TextWeight.heavy,
                          TextTone.primary,
                        ]),
                      ),
                    ),
                    TactileButton.icon(
                      icon: Icons.close,
                      tone: TactileTone.text,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                _TagFilterGroup(
                  title: 'Deck Tags',
                  tags: ViewDecksLocalPage._deckTags,
                  selected: draft.value.deckTags,
                  onToggle: (tag) =>
                      draft.value = draft.value.toggleDeckTag(tag),
                ),
                SizedBox(height: 22.h),
                _TagFilterGroup(
                  title: 'Card Template Tags',
                  tags: ViewDecksLocalPage._cardTemplateTags,
                  selected: draft.value.cardTemplateTags,
                  onToggle: (tag) =>
                      draft.value = draft.value.toggleCardTemplateTag(tag),
                ),
                SizedBox(height: 22.h),
                _TagFilterGroup(
                  title: 'Review Card Tags',
                  tags: ViewDecksLocalPage._reviewCardTags,
                  selected: draft.value.reviewCardTags,
                  onToggle: (tag) =>
                      draft.value = draft.value.toggleReviewCardTag(tag),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Expanded(
                      child: TactileButton(
                        tone: TactileTone.ghost,
                        onPressed: () => draft.value = const _DeckFilterState(),
                        child: const Text('Clear'),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: TactileButton(
                        tone: TactileTone.filled,
                        onPressed: () => Navigator.of(context).pop(draft.value),
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TagFilterGroup extends StatelessWidget {
  const _TagFilterGroup({
    required this.title,
    required this.tags,
    required this.selected,
    required this.onToggle,
  });

  final String title;
  final List<String> tags;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

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
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: [
            for (final tag in tags)
              TactileButton(
                size: TactileSize.sm,
                depth: TactileDepth.flat,
                selected: selected.contains(tag),
                tone: selected.contains(tag)
                    ? TactileTone.filled
                    : TactileTone.ghost,
                onPressed: () => onToggle(tag),
                child: Text(tag),
              ),
          ],
        ),
      ],
    );
  }
}

class _ActiveFilterChips extends StatelessWidget {
  const _ActiveFilterChips({required this.filters, required this.onClear});

  final _DeckFilterState filters;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final chips = [
      for (final tag in filters.deckTags) 'Deck: $tag',
      for (final tag in filters.cardTemplateTags) 'Template: $tag',
      for (final tag in filters.reviewCardTags) 'Review: $tag',
    ];

    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (final chip in chips)
          TactileButton(
            size: TactileSize.sm,
            depth: TactileDepth.flat,
            tone: TactileTone.ghost,
            child: Text(chip),
          ),
        TactileButton(
          size: TactileSize.sm,
          tone: TactileTone.text,
          onPressed: onClear,
          child: const Text('Clear all'),
        ),
      ],
    );
  }
}

class _DeckResultSummary extends StatelessWidget {
  const _DeckResultSummary({required this.count, required this.total});

  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Text(
      '$count of $total decks',
      style: appTextStyle.resolve(tokens, [
        TextSize.labelSmall,
        TextWeight.heavy,
        TextTone.muted,
      ]),
    );
  }
}

class _DeckCard extends StatelessWidget {
  const _DeckCard(this.deck);

  final _DeckPreview deck;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Surface(
      style: surfaceStyle.resolve(tokens, const [SurfaceTone.surface]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TactileButton.icon(
                icon: Icons.style,
                tone: TactileTone.ghost,
                onPressed: () {},
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Text(
                  deck.title,
                  style: appTextStyle.resolve(tokens, [
                    TextSize.labelLarge,
                    TextWeight.heavy,
                    TextTone.primary,
                  ]),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Text(
            deck.description,
            style: appTextStyle.resolve(tokens, [
              TextSize.label,
              TextWeight.body,
              TextTone.secondary,
            ]),
          ),
          SizedBox(height: 18.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _DeckMetaChip('${deck.cardCount} cards'),
              _DeckMetaChip('${deck.usedCount} reviews'),
              _DeckMetaChip(deck.formattedDate),
            ],
          ),
          SizedBox(height: 18.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              for (final tag in deck.deckTags)
                _TagPill(label: tag, tone: TactileTone.filled),
              for (final tag in deck.cardTemplateTags)
                _TagPill(label: tag, tone: TactileTone.ghost),
              for (final tag in deck.reviewCardTags)
                _TagPill(label: tag, tone: TactileTone.good),
            ],
          ),
        ],
      ),
    );
  }
}

class _DeckMetaChip extends StatelessWidget {
  const _DeckMetaChip(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: tokens.softGray,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: tokens.borderNeutralSubtle),
      ),
      child: Text(
        label,
        style: appTextStyle.resolve(tokens, [
          TextSize.labelSmall,
          TextWeight.heavy,
          TextTone.muted,
        ]),
      ),
    );
  }
}

class _TagPill extends StatelessWidget {
  const _TagPill({required this.label, required this.tone});

  final String label;
  final TactileTone tone;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      size: TactileSize.sm,
      depth: TactileDepth.flat,
      tone: tone,
      child: Text(label),
    );
  }
}

class _FilterCountBadge extends StatelessWidget {
  const _FilterCountBadge(this.count);

  final int count;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();

    return Container(
      width: 22.w,
      height: 22.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: tokens.colorTextOnBrand,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$count',
        style: TextStyle(
          color: tokens.primary,
          fontSize: 11.sp,
          fontWeight: tokens.fontWeightTextHeavy,
        ),
      ),
    );
  }
}

class _DeckFilterState {
  const _DeckFilterState({
    this.deckTags = const {},
    this.cardTemplateTags = const {},
    this.reviewCardTags = const {},
  });

  final Set<String> deckTags;
  final Set<String> cardTemplateTags;
  final Set<String> reviewCardTags;

  int get activeCount =>
      deckTags.length + cardTemplateTags.length + reviewCardTags.length;

  _DeckFilterState toggleDeckTag(String tag) {
    return _copyWithToggled(deckTags: deckTags, tag: tag);
  }

  _DeckFilterState toggleCardTemplateTag(String tag) {
    return _copyWithToggled(cardTemplateTags: cardTemplateTags, tag: tag);
  }

  _DeckFilterState toggleReviewCardTag(String tag) {
    return _copyWithToggled(reviewCardTags: reviewCardTags, tag: tag);
  }

  _DeckFilterState _copyWithToggled({
    Set<String>? deckTags,
    Set<String>? cardTemplateTags,
    Set<String>? reviewCardTags,
    required String tag,
  }) {
    Set<String> toggle(Set<String> source) {
      final next = {...source};
      next.contains(tag) ? next.remove(tag) : next.add(tag);
      return next;
    }

    return _DeckFilterState(
      deckTags: deckTags == null ? this.deckTags : toggle(deckTags),
      cardTemplateTags: cardTemplateTags == null
          ? this.cardTemplateTags
          : toggle(cardTemplateTags),
      reviewCardTags: reviewCardTags == null
          ? this.reviewCardTags
          : toggle(reviewCardTags),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _DeckFilterState &&
        _setEquals(deckTags, other.deckTags) &&
        _setEquals(cardTemplateTags, other.cardTemplateTags) &&
        _setEquals(reviewCardTags, other.reviewCardTags);
  }

  @override
  int get hashCode => Object.hash(
    Object.hashAllUnordered(deckTags),
    Object.hashAllUnordered(cardTemplateTags),
    Object.hashAllUnordered(reviewCardTags),
  );
}

class _DeckPreview {
  const _DeckPreview({
    required this.title,
    required this.description,
    required this.cardCount,
    required this.lastUpdated,
    required this.usedCount,
    required this.deckTags,
    required this.cardTemplateTags,
    required this.reviewCardTags,
  });

  final String title;
  final String description;
  final int cardCount;
  final DateTime lastUpdated;
  final int usedCount;
  final Set<String> deckTags;
  final Set<String> cardTemplateTags;
  final Set<String> reviewCardTags;

  String get formattedDate =>
      '${lastUpdated.month}/${lastUpdated.day}/${lastUpdated.year}';
}

extension on DeckSortOption {
  String get label {
    return switch (this) {
      DeckSortOption.alphabet => 'Alphabet',
      DeckSortOption.latest => 'Latest',
      DeckSortOption.oldest => 'Oldest',
      DeckSortOption.leastUsed => 'Least Used',
      DeckSortOption.mostUsed => 'Most Used',
    };
  }
}

bool _setEquals(Set<String> a, Set<String> b) {
  if (a.length != b.length) return false;
  return a.every(b.contains);
}
