import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:react_to_flutter/widgets/study_session/study_session.action_bar.dart';
import 'package:react_to_flutter/widgets/study_session/study_session.appbar.dart';
import 'package:react_to_flutter/widgets/study_session/study_session.card_stage.dart';
import 'package:react_to_flutter/widgets/study_session/study_session.models.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';

class StudySessionPage extends HookWidget {
  const StudySessionPage({super.key});

  static const _mockQueue = [
    StudyFlashcard(id: '1', front: '勉強', back: 'benkyou (study)'),
    StudyMcqCard(
      id: '2',
      prompt: 'Which particle indicates the topic of a sentence?',
      options: ['を (o)', 'は (wa)', 'が (ga)', 'で (de)'],
      correctOption: 'は (wa)',
    ),
    StudyBlanksCard(
      id: '3',
      prefix: '私は毎日',
      blankAnswer: '図書館',
      suffix: 'で勉強します。',
    ),
    StudyMatchCard(
      id: '4',
      pairs: [
        StudyMatchPair(term: '犬', match: 'Dog'),
        StudyMatchPair(term: '猫', match: 'Cat'),
        StudyMatchPair(term: '鳥', match: 'Bird'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const _StudySessionScaffold();
  }
}

class _StudySessionScaffold extends HookWidget {
  const _StudySessionScaffold();

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final currentIndex = useState(0);
    final isRevealed = useState(false);
    final selectedOption = useState<String?>(null);
    final blankInput = useState('');
    final selectedMatch = useState<String?>(null);
    final matchedItems = useState<Set<String>>(<String>{});

    final currentCard = StudySessionPage._mockQueue[currentIndex.value];
    final progress = currentIndex.value / StudySessionPage._mockQueue.length;
    final showCheckAnswer =
        currentCard is StudyMcqCard || currentCard is StudyBlanksCard;
    final checkAnswerEnabled = switch (currentCard) {
      StudyMcqCard() => selectedOption.value != null,
      StudyBlanksCard() => blankInput.value.trim().isNotEmpty,
      _ => false,
    };

    useEffect(() {
      isRevealed.value = false;
      selectedOption.value = null;
      blankInput.value = '';
      selectedMatch.value = null;
      matchedItems.value = <String>{};
      return null;
    }, [currentIndex.value]);

    void closeSession() {
      if (context.canPop()) {
        context.pop();
        return;
      }
      context.go('/');
    }

    void rateCurrentCard(String rating) {
      debugPrint('Card ${currentCard.id} rated: $rating');

      if (currentIndex.value < StudySessionPage._mockQueue.length - 1) {
        currentIndex.value += 1;
        isRevealed.value = false;
        return;
      }

      closeSession();
    }

    return Scaffold(
      backgroundColor: tokens.backgroundPage,
      body: SafeArea(
        child: Column(
          children: [
            StudySessionAppbar(
              current: currentIndex.value + 1,
              total: StudySessionPage._mockQueue.length,
              progress: progress,
              onClose: closeSession,
            ),
            Expanded(
              child: ThemeVariantsOverride<AppTokens>(
                lightThemeId: 'boomondai',
                darkThemeId: 'boomondai',
                child: StudySessionCardStage(
                  card: currentCard,
                  revealed: isRevealed.value,
                  onReveal: () => isRevealed.value = true,
                  selectedOption: selectedOption.value,
                  onOptionSelected: (option) => selectedOption.value = option,
                  blankInput: blankInput.value,
                  onBlankInputChanged: (value) => blankInput.value = value,
                  selectedMatch: selectedMatch.value,
                  matchedItems: matchedItems.value,
                  onSelectedMatchChanged: (value) =>
                      selectedMatch.value = value,
                  onMatchedItemsChanged: (value) => matchedItems.value = value,
                ),
              ),
            ),
            StudySessionActionBar(
              revealed: isRevealed.value,
              showCheckAnswer: showCheckAnswer,
              checkAnswerEnabled: checkAnswerEnabled,
              onCheckAnswer: () => isRevealed.value = true,
              onRateAgain: () => rateCurrentCard('again'),
              onRateHard: () => rateCurrentCard('hard'),
              onRateGood: () => rateCurrentCard('good'),
              onRateEasy: () => rateCurrentCard('easy'),
            ),
          ],
        ),
      ),
    );
  }
}
