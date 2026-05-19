import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_variants/theme_variants.dart';

import '../theme/app_tokens.dart';
import 'package:react_to_flutter/variant_styles/variant_styles.barrel.dart';

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
    this.textAlign,
  });

  final Widget child;
  final VoidCallback? onPressed;
  final IconData? icon;
  final TactileTone tone;
  final TactileSize size;
  final bool selected;
  final bool expand;
  final TextAlign? textAlign;

  TactileState getState() {
    if (onPressed == null) {
      return TactileState.disabled;
    } else if (selected) {
      return TactileState.selected;
    } else {
      return TactileState.idle;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = context.themeTokens<AppTokens>();
    final state = useState(getState());
    useEffect(() {
      state.value = getState();
      return null;
    }, [onPressed, selected, tone]);
    final resolvedStyle = tactileButtonStyle.resolve(tokens, <Object>[
      tone,
      size,
      state.value,
    ]);

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
    final rowAlignment = switch (textAlign) {
      TextAlign.left || TextAlign.start => MainAxisAlignment.start,
      TextAlign.right || TextAlign.end => MainAxisAlignment.end,
      _ => MainAxisAlignment.center,
    };

    final contentStyle = resolvedStyle.copyWith(
      transform: Matrix4.translationValues(
        0,
        state.value == TactileState.pressed &&
                !(state.value == TactileState.disabled)
            ? 4
            : 0,
        0,
      ),
      constraints: BoxConstraints(
        minWidth: minSize.width,
        minHeight: minSize.height,
      ),
      padding: padding,
      opacity: state.value == TactileState.disabled ? 0.5 : 1,
      contentStyle: resolvedStyle.contentStyle.copyWith(textAlign: textAlign),
    );

    final content = Surface(
      style: contentStyle,
      duration: const Duration(milliseconds: 130),
      curve: Curves.easeOutCubic,
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: rowAlignment,
        children: [
          if (icon != null) ...[
            Icon(icon),
            if (size != TactileSize.icon) const SizedBox(width: 10),
          ],
          if (size != TactileSize.icon)
            (expand ? Expanded(child: child) : Flexible(child: child)),
        ],
      ),
    );

    final paintedContent = tone == TactileTone.dashed
        ? CustomPaint(
            foregroundPainter: _DashedBorderPainter(
              color: state.value == TactileState.hovered
                  ? tokens.primary
                  : tokens.borderNeutralSubtle,
              radius: tokens.radius2xl,
            ),
            child: content,
          )
        : content;

    return MouseRegion(
      cursor: state.value == TactileState.disabled
          ? SystemMouseCursors.forbidden
          : SystemMouseCursors.click,
      onEnter: state.value == TactileState.disabled
          ? null
          : (_) => state.value = TactileState.hovered,
      onExit: state.value == TactileState.disabled
          ? null
          : (_) => state.value = TactileState.idle,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: state.value == TactileState.disabled
            ? null
            : (_) => state.value = TactileState.pressed,
        onTapCancel: state.value == TactileState.disabled
            ? null
            : () => state.value = TactileState.idle,
        onTapUp: state.value == TactileState.disabled
            ? null
            : (_) {
                onPressed?.call();
                state.value = TactileState.hovered;
              },
        child: expand
            ? SizedBox(width: double.infinity, child: paintedContent)
            : paintedContent,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({required this.color, required this.radius});

  static const _strokeWidth = 2.0;
  static const _dashLength = 8.0;
  static const _gapLength = 5.0;

  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    final rect = Offset.zero & size;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect.deflate(_strokeWidth / 2),
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final end = (distance + _dashLength).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += _dashLength + _gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return color != oldDelegate.color || radius != oldDelegate.radius;
  }
}
