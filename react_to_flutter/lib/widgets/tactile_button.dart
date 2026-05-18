import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import '../theme/app_variant_styles.dart';

class TactileButton extends HookWidget {
  const TactileButton({
    required this.child,
    this.onPressed,
    this.icon,
    this.tone = TactileTone.secondary,
    this.size = TactileSize.md,
    this.selected = false,
    this.expand = false,
    super.key,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final IconData? icon;
  final TactileTone tone;
  final TactileSize size;
  final bool selected;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final pressed = useState(false);
    final tokens = context.themeTokens<AppTokens>();
    final disabled = onPressed == null;
    final state = switch ((disabled, selected, tone)) {
      (true, _, _) => TactileState.disabled,
      (_, _, TactileTone.text) => TactileState.idle,
      (_, true, _) => TactileState.selected,
      _ => TactileState.idle,
    };
    final decorationVariants = <Object>[tone, state];
    final textVariants = <Object>[tone, size];

    final padding = switch (size) {
      TactileSize.sm => const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      TactileSize.md => const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ),
      TactileSize.lg => const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 18,
      ),
      TactileSize.icon => EdgeInsets.zero,
    };

    final minSize = size == TactileSize.icon
        ? const Size.square(48)
        : Size.zero;

    final content = AnimatedContainer(
      duration: const Duration(milliseconds: 130),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(
        0,
        pressed.value && !disabled ? 4 : 0,
        0,
      ),
      constraints: BoxConstraints(
        minWidth: minSize.width,
        minHeight: minSize.height,
      ),
      padding: padding,
      decoration: pressed.value && !disabled
          ? tactileButtonDecoration
                .resolve(tokens, decorationVariants)
                .copyWith(boxShadow: const [])
          : tactileButtonDecoration.resolve(tokens, decorationVariants),
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: IconTheme(
          data: IconThemeData(
            color: tactileButtonText.resolve(tokens, textVariants).color,
            size: size == TactileSize.icon ? 22 : 18,
          ),
          child: DefaultTextStyle(
            style: tactileButtonText.resolve(tokens, textVariants),
            textAlign: TextAlign.center,
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon),
                  if (size != TactileSize.icon) const SizedBox(width: 10),
                ],
                if (size != TactileSize.icon) Flexible(child: child),
              ],
            ),
          ),
        ),
      ),
    );

    return MouseRegion(
      cursor: disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: disabled ? null : (_) => pressed.value = true,
        onTapCancel: disabled ? null : () => pressed.value = false,
        onTapUp: disabled
            ? null
            : (_) {
                pressed.value = false;
                onPressed?.call();
              },
        child: expand
            ? SizedBox(width: double.infinity, child: content)
            : content,
      ),
    );
  }
}
