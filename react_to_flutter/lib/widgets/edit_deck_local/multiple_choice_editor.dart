import 'package:flutter/material.dart';
import 'package:react_to_flutter/widgets/edit_deck_local/multiple_choice_options_panel.dart';

import '../../widgets/text_field_card.dart';
import 'responsive_two_column.dart';

class MultipleChoiceEditor extends StatelessWidget {
  const MultipleChoiceEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveTwoColumn(
      children: [
        TextFieldCard(
          title: 'Front (Prompt)',
          placeholder: 'Type a question...',
        ),
        MultipleChoiceOptionsPanel(),
      ],
    );
  }
}
