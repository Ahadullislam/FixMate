import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import '../models/service.dart';
import '../utils/mock_data.dart'; // For mock provider data
import 'booking_flow_page.dart';

class ServiceDetailsPage extends StatelessWidget {
  final Service service;

  const ServiceDetailsPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // Use the first mock provider for demonstration
    final mockProvider = MockData.getMockProviders()[0];

    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.background,
            expandedHeight: 250.h,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                service.name,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    service.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.darkSurfaceColor,
                      child: Icon(
                        Icons.broken_image,
                        color: AppTheme.textLightColor,
                        size: 80.w,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppTheme.darkBackgroundColor.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: AppTheme.heading3.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    service.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    'Service Provider',
                    style: AppTheme.heading3.copyWith(color: Colors.white),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppTheme.darkSurfaceColor,
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      boxShadow: AppTheme.cardShadow,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30.w,
                          backgroundImage: NetworkImage(mockProvider.photoUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            // Fallback to an icon if image fails to load
                            print('Error loading provider image: $exception');
                          },
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mockProvider.name,
                              style: AppTheme.bodyLarge.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  mockProvider.rating.toString(),
                                  style: AppTheme.bodyMedium.copyWith(
                                    color: AppTheme.textLightColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Book Now Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BookingFlowPage(service: service),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Book Now',
                        style: AppTheme.button.copyWith(fontSize: 18.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
