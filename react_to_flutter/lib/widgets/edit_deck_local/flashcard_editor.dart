import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/direction_selector.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/types.dart';

import '../../widgets/text_field_card.dart';
import 'responsive_two_column.dart';

class FlashcardEditor extends HookWidget {
  const FlashcardEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final direction = useState(DirectionType.normal);
    final directionHint = switch (direction.value) {
      DirectionType.both =>
        'Generates 2 Notes: Front to Back and Back to Front.',
      DirectionType.reverse => 'Generates 1 Note: Back to Front.',
      DirectionType.normal => 'Generates 1 Note: Front to Back.',
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24,
      children: [
        DirectionSelector(
          selected: direction.value,
          hint: directionHint,
          onChanged: (value) => direction.value = value,
        ),
        const ResponsiveTwoColumn(
          children: [
            TextFieldCard(
              title: 'Front (Prompt)',
              placeholder: 'Type a word...',
            ),
            TextFieldCard(
              title: 'Back (Answer)',
              placeholder: 'Type the translation...',
            ),
          ],
        ),
      ],
    );
  }
}
