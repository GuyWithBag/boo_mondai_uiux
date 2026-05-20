import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/edit_deck.appbar.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/edit_deck.sidebar.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/fill_in_the_blanks.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/flashcard_editor.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/format_selector.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/matching_type_editor.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/multiple_choice_editor.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/types.dart';

class EditDeckPage extends HookWidget {
  const EditDeckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(
      initialLength: FormatType.values.length,
    );
    final pageController = usePageController(initialPage: tabController.index);
    final selectedFormatIndex = useState(tabController.index);
    final tokens = context.themeTokens<AppTokens>();

    return Scaffold(
      backgroundColor: tokens.backgroundPage,
      appBar: EditDeckAppbar(tokens: tokens),
      body: SafeArea(
        child: Column(
          children: [
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
                                  FormatSelector(
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
