import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/service.dart';
import '../utils/theme.dart';

class ServiceTag extends StatefulWidget {
  final ServiceModel service;
  final bool isSelected;
  final VoidCallback? onTap;
  final bool isInteractive;

  const ServiceTag({
    super.key,
    required this.service,
    this.isSelected = false,
    this.onTap,
    this.isInteractive = true,
  });

  @override
  State<ServiceTag> createState() => _ServiceTagState();
}

class _ServiceTagState extends State<ServiceTag> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final decoration = isDark
        ? AppTheme.darkNeumorphismDecoration
        : AppTheme.neumorphismDecoration;

    return Semantics(
          label: '${widget.service.name} service tag',
          button: widget.isInteractive,
          selected: widget.isSelected,
          child: MouseRegion(
            onEnter: (_) {
              if (widget.isInteractive) {
                setState(() => _isHovered = true);
              }
            },
            onExit: (_) {
              if (widget.isInteractive) {
                setState(() => _isHovered = false);
              }
            },
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutQuart,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: decoration.copyWith(
                  color: widget.isSelected
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                      : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  boxShadow: [
                    BoxShadow(
                      color: widget.isSelected
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.3)
                          : Colors.black.withOpacity(0.05),
                      blurRadius: _isHovered ? 12 : 8,
                      offset: Offset(0, _isHovered ? 4 : 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.service.icon != null) ...[
                      Icon(
                        widget.service.icon,
                        size: 16.w,
                        color: widget.isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.7),
                      ),
                      SizedBox(width: 4.w),
                    ],
                    Text(
                      widget.service.name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : FontWeight.w500,
                        color: widget.isSelected
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 200.ms,
          curve: Curves.easeOutQuart,
        )
        .fadeIn(duration: 200.ms);
  }
}
