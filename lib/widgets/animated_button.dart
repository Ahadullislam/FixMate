import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final Color? color;
  final double? width;
  final double? height;
  final String? semanticsLabel;

  const AnimatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.color,
    this.width,
    this.height,
    this.semanticsLabel,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = true);
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
    }
  }

  void _handleTapCancel() {
    if (!widget.isDisabled && !widget.isLoading) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final decoration = isDark ? AppTheme.darkNeumorphismDecoration : AppTheme.neumorphismDecoration;
    final color = widget.color ?? Theme.of(context).colorScheme.primary;

    return Semantics(
      label: widget.semanticsLabel ?? widget.text,
      button: true,
      enabled: !widget.isDisabled && !widget.isLoading,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          onTap: widget.isDisabled || widget.isLoading ? null : widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOutQuart,
            width: widget.width,
            height: widget.height ?? 48.h,
            decoration: decoration.copyWith(
              color: widget.isDisabled
                  ? Colors.grey.withOpacity(0.3)
                  : color.withOpacity(_isPressed ? 0.8 : 0.1),
              boxShadow: [
                BoxShadow(
                  color: widget.isDisabled
                      ? Colors.black.withOpacity(0.1)
                      : color.withOpacity(_isHovered ? 0.3 : 0.1),
                  blurRadius: _isHovered ? 12 : 8,
                  offset: Offset(0, _isPressed ? 2 : _isHovered ? 4 : 2),
                ),
              ],
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.w,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(
                            widget.icon,
                            size: 20.w,
                            color: widget.isDisabled
                                ? Colors.grey
                                : color,
                          ),
                          SizedBox(width: 8.w),
                        ],
                        Text(
                          widget.text,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: widget.isDisabled
                                ? Colors.grey
                                : color,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    ).animate()
      .scale(
        begin: const Offset(0.95, 0.95),
        end: const Offset(1, 1),
        duration: 200.ms,
        curve: Curves.easeOutQuart,
      )
      .fadeIn(duration: 200.ms);
  }
} 