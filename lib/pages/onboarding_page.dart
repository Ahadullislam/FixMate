import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final Map<int, bool> _animationLoaded = {};

  final List<OnboardingItem> _items = [
    OnboardingItem(
      title: 'Find Trusted Service Providers',
      description: 'Discover reliable professionals for all your home service needs.',
      animation: 'assets/animations/onboarding1.json',
      fallbackIcon: Icons.people,
    ),
    OnboardingItem(
      title: 'Book Services Instantly',
      description: 'Schedule appointments with just a few taps.',
      animation: 'assets/animations/onboarding2.json',
      fallbackIcon: Icons.calendar_today,
    ),
    OnboardingItem(
      title: 'Track Your Bookings',
      description: 'Manage all your service appointments in one place.',
      animation: 'assets/animations/onboarding3.json',
      fallbackIcon: Icons.track_changes,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _onGetStartedPressed() {
    Navigator.pushReplacementNamed(context, '/landing');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: TextButton(
                  onPressed: _onGetStartedPressed,
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ),
            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildPage(_items[index], index);
                },
              ),
            ),
            // Bottom section
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _items.length,
                      (index) => _buildPageIndicator(index),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Get started button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _onGetStartedPressed,
                      child: Text(
                        _currentPage == _items.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: AppTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingItem item, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animation
          _animationLoaded[index] == true
              ? Lottie.asset(
                  item.animation,
                  width: 300.w,
                  height: 300.w,
                  fit: BoxFit.contain,
                  onLoaded: (composition) {
                    setState(() {
                      _animationLoaded[index] = true;
                    });
                  },
                )
              : Icon(
                  item.fallbackIcon,
                  size: 120.w,
                  color: AppTheme.primaryColor,
                )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(delay: 200.ms, duration: 600.ms),

          SizedBox(height: 32.h),

          // Title
          Text(
            item.title,
            style: AppTheme.heading2.copyWith(
              fontSize: 24.sp,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 600.ms),

          SizedBox(height: 16.h),

          // Description
          Text(
            item.description,
            style: AppTheme.bodyLarge.copyWith(
              fontSize: 16.sp,
              color: AppTheme.textLightColor,
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      width: 8.w,
      height: 8.w,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index
            ? AppTheme.primaryColor
            : AppTheme.primaryColor.withOpacity(0.3),
      ),
    )
        .animate()
        .scale(
          duration: 300.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .scale(
          duration: 300.ms,
          curve: Curves.easeInOut,
        );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String animation;
  final IconData fallbackIcon;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.animation,
    required this.fallbackIcon,
  });
}
