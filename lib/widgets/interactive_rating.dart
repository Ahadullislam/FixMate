import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';

class InteractiveRating extends StatefulWidget {
  final double initialRating;
  final Function(double) onRatingChanged;
  final bool isInteractive;
  final double size;
  final Color? color;

  const InteractiveRating({
    super.key,
    required this.initialRating,
    required this.onRatingChanged,
    this.isInteractive = true,
    this.size = 24,
    this.color,
  });

  @override
  State<InteractiveRating> createState() => _InteractiveRatingState();
}

class _InteractiveRatingState extends State<InteractiveRating> {
  late double _rating;
  double? _hoverRating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRating(double rating) {
    if (widget.isInteractive) {
      setState(() {
        _rating = rating;
      });
      widget.onRatingChanged(rating);
    }
  }

  void _updateHoverRating(double? rating) {
    if (widget.isInteractive) {
      setState(() {
        _hoverRating = rating;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).colorScheme.primary;
    final displayRating = _hoverRating ?? _rating;

    return Semantics(
      label: 'Rating: ${_rating.toStringAsFixed(1)} out of 5',
      value: _rating.toStringAsFixed(1),
      button: widget.isInteractive,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          final isHalfStar = displayRating - index >= 0.5 && displayRating - index < 1;
          final isFullStar = displayRating - index >= 1;
          final starColor = isFullStar || isHalfStar ? color : Colors.grey[300];

          return MouseRegion(
            onEnter: (_) => _updateHoverRating(index + 1.0),
            onExit: (_) => _updateHoverRating(null),
            child: GestureDetector(
              onTapDown: (details) {
                final box = context.findRenderObject() as RenderBox;
                final localPosition = details.localPosition;
                final starWidth = box.size.width / 5;
                final starIndex = (localPosition.dx / starWidth).floor();
                final isHalf = localPosition.dx - (starIndex * starWidth) < starWidth / 2;
                _updateRating(starIndex + (isHalf ? 0.5 : 1.0));
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutQuart,
                child: Icon(
                  isHalfStar ? Icons.star_half : Icons.star,
                  size: widget.size.w,
                  color: starColor,
                ),
              ),
            ),
          ).animate()
            .scale(
              begin: const Offset(0.8, 0.8),
              end: const Offset(1, 1),
              duration: 200.ms,
              curve: Curves.easeOutQuart,
            )
            .fadeIn(duration: 200.ms);
        }),
      ),
    );
  }
} 