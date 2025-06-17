import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).appBarTheme.iconTheme?.color ?? Theme.of(context).colorScheme.onBackground),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Support & Help',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How can we help you?',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 24.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'Choose from the options below or contact us directly.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              SizedBox(height: 32.h),
              _buildSupportOptionCard(
                icon: Icons.question_answer,
                title: 'Frequently Asked Questions',
                description: 'Find answers to common questions.',
                onTap: () {
                  // TODO: Navigate to FAQ page
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('FAQ page coming soon!',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor)),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      backgroundColor: AppTheme.darkSurfaceColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              _buildSupportOptionCard(
                icon: Icons.contact_support,
                title: 'Contact Us',
                description: 'Submit a support ticket or chat with us.',
                onTap: () {
                  // TODO: Navigate to contact form/chat support
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Contact options coming soon!',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor)),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      backgroundColor: AppTheme.darkSurfaceColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              _buildSupportOptionCard(
                icon: Icons.phone,
                title: 'Call Us',
                description: 'Speak directly with our support team.',
                onTap: () {
                  // TODO: Implement direct call functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Call us at: +8801234567890',
                          style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor)),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
                      ),
                      backgroundColor: AppTheme.darkSurfaceColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),
              Center(
                child: Text(
                  'We are here to help you 24/7.',
                  style: AppTheme.bodyMedium.copyWith(color: AppTheme.textLightColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportOptionCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppTheme.darkSurfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Row(
          children: [
            Icon(icon, size: 36.w, color: AppTheme.primaryColor),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AppTheme.bodySmall.copyWith(color: AppTheme.textLightColor),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 20.w, color: AppTheme.textLightColor),
          ],
        ),
      ),
    );
  }
}
