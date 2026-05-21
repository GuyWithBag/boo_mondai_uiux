import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_variants/theme_variants.dart';

import '../../theme/app_tokens.dart';
import '../../variant_styles/variant_styles.barrel.dart';
import '../../widgets/tactile_button.dart';
import 'tactile_radio_circle.dart';

class MultipleChoiceOption extends HookWidget {
  const MultipleChoiceOption({
    required this.value,
    this.correct = false,
    this.state = MultipleChoiceOptionState.idle,
    this.tone = MultipleChoiceOptionTone.neutral,
    this.isEditable = true,
    this.showRadio = false,
    this.onPressed,
    super.key,
  });

  final String value;
  final bool correct;
  final MultipleChoiceOptionState state;
  final MultipleChoiceOptionTone tone;
  final bool isEditable;
  final bool showRadio;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final controller = useTextEditingController(text: value);
    final hovered = useState(false);
    final effectiveState =
        state == MultipleChoiceOptionState.idle &&
            hovered.value &&
            onPressed != null
        ? MultipleChoiceOptionState.hovered
        : state;
    final resolvedStyle = multipleChoiceOptionStyle.resolve(tokens, [
      effectiveState,
      tone,
    ]);
    final effectiveTone =
        resolvedStyle.buttonTone ??
        (correct ? TactileTone.success : TactileTone.ghost);
    final effectiveSelected = resolvedStyle.selected ?? false;
    final effectiveOpacity = resolvedStyle.opacity ?? 1;
    final effectiveTextTone = resolvedStyle.textTone ?? TextTone.primary;
    final effectiveOnPressed = onPressed ?? (!isEditable ? () {} : null);
    final optionText = isEditable
        ? TextField(
            controller: controller,
            style: TextStyle(
              color: tokens.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
            decoration: const InputDecoration.collapsed(hintText: ''),
          )
        : Text(
            value,
            style: appTextStyle.resolve(tokens, [
              TextSize.labelLarge,
              TextWeight.heavy,
              effectiveTextTone,
            ]),
          );

    return MouseRegion(
      onEnter: (_) => hovered.value = true,
      onExit: (_) => hovered.value = false,
      child: IgnorePointer(
        ignoring: onPressed == null && !isEditable,
        child: Opacity(
          opacity: effectiveOpacity,
          child: TactileButton(
            tone: effectiveTone,
            depth: TactileDepth.flat,
            selected: effectiveSelected,
            mainAxisAlignment: MainAxisAlignment.start,
            onPressed: effectiveOnPressed,
            leading: showRadio ? TactileRadioCircle(correct: correct) : null,
            trailing: isEditable
                ? IconButton(
                    color: tokens.textMuted,
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  )
                : null,
            child: optionText,
          ),
        ),
      ),
    );
  }
}
