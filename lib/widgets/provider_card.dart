import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/provider.dart';
import '../utils/theme.dart';

class ProviderCard extends StatelessWidget {
  final ProviderModel provider;
  final VoidCallback onTap;

  const ProviderCard({super.key, required this.provider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final decoration = isDark
        ? AppTheme.darkNeumorphismDecoration
        : AppTheme.neumorphismDecoration;

    return Semantics(
          label: 'Service provider card for ${provider.name}',
          button: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                decoration: decoration,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Provider image with gradient overlay
                    Stack(
                      children: [
                        Hero(
                          tag: 'provider_image_${provider.id}',
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16.r),
                            ),
                            child: Image.network(
                              provider.photoUrl,
                              height: 180.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 180.h,
                                  width: double.infinity,
                                  color: Colors.grey[200],
                                  child: Icon(
                                    Icons.person,
                                    size: 64.w,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Gradient overlay
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.r),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Rating badge
                        Positioned(
                          top: 12.h,
                          right: 12.w,
                          child: Hero(
                            tag: 'provider_rating_${provider.id}',
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 16.w,
                                    color: Colors.amber,
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    provider.rating.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Provider name
                          Hero(
                            tag: 'provider_name_${provider.id}',
                            child: Text(
                              provider.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          // Provider category
                          Text(
                            provider.skills.isNotEmpty
                                ? provider.skills.first
                                : '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Provider services
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: provider.skills.map((skill) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 6.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  skill,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 12.h),
                          // Provider location
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 16.w,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                provider.serviceArea,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(
          begin: 0.2,
          end: 0,
          duration: 600.ms,
          curve: Curves.easeOutQuart,
        )
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.easeOutQuart,
        );
  }
}
