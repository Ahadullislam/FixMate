import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:
                Theme.of(context).appBarTheme.iconTheme?.color ??
                Theme.of(context).colorScheme.onBackground,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Dashboard',
          style:
              Theme.of(context).appBarTheme.titleTextStyle ??
              TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
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
                'Welcome to your Dashboard!',
                style:
                    Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 24.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ) ??
                    TextStyle(
                      fontSize: 24.sp,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Here you can manage your bookings, profile, and more.',
                style:
                    Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color:
                          Theme.of(context).textTheme.bodySmall?.color ??
                          Theme.of(context).colorScheme.onBackground,
                    ) ??
                    TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              SizedBox(height: 32.h),
              _buildDashboardCard(
                context,
                icon: Icons.book_online,
                title: 'My Bookings',
                description: 'View your ongoing and completed bookings.',
                onTap: () {
                  Navigator.pushNamed(context, '/bookings');
                },
              ),
              SizedBox(height: 16.h),
              _buildDashboardCard(
                context,
                icon: Icons.person,
                title: 'Edit Profile',
                description: 'Update your personal information.',
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              SizedBox(height: 16.h),
              _buildDashboardCard(
                context,
                icon: Icons.wallet,
                title: 'My Wallet',
                description: 'Check your balance and transaction history.',
                onTap: () {
                  Navigator.pushNamed(context, '/wallet');
                },
              ),
              SizedBox(height: 16.h),
              _buildDashboardCard(
                context,
                icon: Icons.contact_support,
                title: 'Support & Help',
                description: 'Get assistance and answers to your questions.',
                onTap: () {
                  Navigator.pushNamed(context, '/support');
                },
              ),
              SizedBox(height: 32.h),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement feedback functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Feedback functionality coming soon!',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppTheme.successColor),
                        ),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.borderRadiusSmall,
                          ),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    'Provide Feedback',
                    style:
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ) ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
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
          color: Theme.of(context).colorScheme.surface,
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
                    style:
                        Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ) ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).textTheme.bodySmall?.color ??
                              Theme.of(context).colorScheme.onSurface,
                        ) ??
                        TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.w,
              color: AppTheme.textLightColor,
            ),
          ],
        ),
      ),
    );
  }
}
