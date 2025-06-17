import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';
import '../services/storage_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Use real user data from AuthProvider

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
          'My Profile',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit,
              color:
                  Theme.of(context).iconTheme.color ??
                  Theme.of(context).colorScheme.onBackground,
            ),
            onPressed: () {
              // TODO: Implement edit profile functionality
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Edit profile functionality coming soon!',
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
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            final user = authProvider.userModel;
            if (user == null) {
              return Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60.w,
                            backgroundImage: NetworkImage(
                              user.photoUrl ??
                                  'https://via.placeholder.com/150',
                            ),
                            onBackgroundImageError: (exception, stackTrace) {
                              print('Error loading user image: $exception');
                            },
                          ),
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final picked = await picker.pickImage(
                                  source: ImageSource.gallery,
                                  imageQuality: 80,
                                );
                                if (picked != null) {
                                  final url = await StorageService()
                                      .uploadProfilePhoto(
                                        user.id,
                                        File(picked.path),
                                      );
                                  if (url != null) {
                                    await Provider.of<AuthProvider>(
                                      context,
                                      listen: false,
                                    ).updateProfilePhoto(url);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Profile photo updated!'),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to upload photo.',
                                        ),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    );
                                  }
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 18.w,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: AppTheme.primaryColor,
                                  size: 20.w,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      .animate()
                      .fadeIn(duration: 600.ms)
                      .scale(delay: 200.ms, duration: 600.ms),
                  SizedBox(height: 16.h),
                  Text(
                        user.name,
                        style: AppTheme.heading2.copyWith(
                          color: Colors.white,
                          fontSize: 28.sp,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 400.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 8.h),
                  Text(
                        user.email,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textLightColor,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 500.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 8.h),
                  Text(
                        user.phone,
                        style: AppTheme.bodyLarge.copyWith(
                          color: AppTheme.textLightColor,
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 600.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 32.h),
                  _buildProfileInfoCard(
                        icon: Icons.location_on,
                        title: 'Address',
                        subtitle: user.address ?? 'N/A',
                      )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 700.ms,
                        duration: 600.ms,
                      ),
                  SizedBox(height: 32.h),
                  SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).logout();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.errorColor,
                          ),
                          child: Text('Log Out', style: AppTheme.button),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: 1000.ms, duration: 600.ms)
                      .slideY(
                        begin: 0.3,
                        end: 0,
                        delay: 1000.ms,
                        duration: 600.ms,
                      ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfileInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: [
          Icon(icon, size: 28.w, color: AppTheme.primaryColor),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textLightColor,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: AppTheme.bodyLarge.copyWith(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
