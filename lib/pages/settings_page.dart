import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
          'Settings',
          style: AppTheme.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Settings',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: SwitchListTile(
                  title: Text(
                    'Dark Mode',
                    style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  ),
                  value: true, // themeProvider.isDarkMode,
                  onChanged: (bool value) {
                    // themeProvider.toggleTheme();
                  },
                  activeColor: AppTheme.primaryColor,
                  inactiveThumbColor: AppTheme.textLightColor,
                  inactiveTrackColor: AppTheme.textLightColor.withOpacity(0.3),
                  secondary: Icon(
                    Icons.dark_mode,
                    color: AppTheme.textLightColor,
                  ), // themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Notification Settings',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: SwitchListTile(
                  title: Text(
                    'Enable Notifications',
                    style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  ),
                  value:
                      true, // TODO: Replace with actual notification setting state
                  onChanged: (bool value) {
                    // TODO: Implement notification toggle logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          value
                              ? 'Notifications Enabled!'
                              : 'Notifications Disabled!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppTheme.successColor,
                              ),
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
                  activeColor: AppTheme.primaryColor,
                  inactiveThumbColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  inactiveTrackColor: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
                  secondary: Icon(
                    Icons.notifications_active,
                    color: AppTheme.textLightColor,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
