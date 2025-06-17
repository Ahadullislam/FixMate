import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print('[DEBUG] SplashPage initState called');
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    _controller.addStatusListener((status) {
      print(
        '[DEBUG] Animation status: '
        '\x1B[33m$status\x1B[0m',
      );
      if (status == AnimationStatus.completed) {
        print('[DEBUG] Navigating to /onboarding');
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('[DEBUG] SplashPage build called');
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo animation
            Animate(
              effects: [
                FadeEffect(duration: 600.ms),
                ScaleEffect(delay: 200.ms, duration: 600.ms),
              ],
              child: Lottie.asset(
                'assets/animations/fixmate_animation1.json',
                controller: _controller,
                width: 200.w,
                height: 200.w,
                fit: BoxFit.contain,
                onLoaded: (composition) {
                  _controller.duration = composition.duration;
                },
              ),
            ),

            SizedBox(height: 24.h),

            // App name
            Text(
                  'FixMate',
                  style: AppTheme.heading1.copyWith(
                    fontSize: 32.sp,
                    color: AppTheme.primaryColor,
                  ),
                )
                .animate()
                .fadeIn(delay: 400.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 600.ms),

            SizedBox(height: 8.h),

            // Tagline
            Text(
                  'Your Home Service Solution',
                  style: AppTheme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    color: AppTheme.textLightColor,
                  ),
                )
                .animate()
                .fadeIn(delay: 600.ms, duration: 600.ms)
                .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),

            SizedBox(height: 48.h),

            // Loading indicator
            CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor,
                  ),
                  strokeWidth: 3.w,
                )
                .animate()
                .fadeIn(delay: 800.ms, duration: 600.ms)
                .scale(delay: 800.ms, duration: 600.ms),
          ],
        ),
      ),
    );
  }
}
