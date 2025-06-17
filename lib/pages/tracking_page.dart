import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';
import '../models/provider.dart';
import '../services/firestore_service.dart';

class TrackingPage extends StatelessWidget {
  final BookingModel booking;

  const TrackingPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    // Fetch provider info from Firestore
    return StreamBuilder<ProviderModel?>(
      stream: FirestoreService().getProviderStream(booking.providerId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final provider = snapshot.data!;
        return Scaffold(
          backgroundColor: AppTheme.darkBackgroundColor,
          appBar: AppBar(
            backgroundColor: AppTheme.darkBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Track Provider',
              style: AppTheme.heading3.copyWith(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  color: AppTheme.darkSurfaceColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map,
                          size: 100.w,
                          color: AppTheme.textLightColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Map Integration Coming Soon',
                          style: AppTheme.bodyLarge.copyWith(
                            color: AppTheme.textLightColor,
                          ),
                        ),
                      ],
                    ), // TODO: Integrate Google Maps here
                  ),
                ),
              ),
              // Provider and Booking Info at the bottom
              Container(
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppTheme.borderRadius),
                  ),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Details',
                      style: AppTheme.heading3.copyWith(color: Colors.white),
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 25.w,
                          backgroundImage: NetworkImage(provider.photoUrl),
                          onBackgroundImageError: (exception, stackTrace) {
                            print('Error loading provider image: $exception');
                          },
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              provider.name,
                              style: AppTheme.bodyLarge.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              booking.serviceType,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textLightColor,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat(
                                'MMM dd',
                              ).format(booking.bookingDateTime),
                              style: AppTheme.bodyMedium.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'h:mm a',
                              ).format(booking.bookingDateTime),
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Estimated Arrival:',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textLightColor,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '10-15 minutes', // TODO: Replace with real-time estimation
                      style: AppTheme.heading2.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/chat',
                            arguments: provider,
                          );
                        },
                        icon: Icon(
                          Icons.chat_bubble_outline,
                          color: AppTheme.primaryColor,
                          size: 20.w,
                        ),
                        label: Text(
                          'Chat with Provider',
                          style: AppTheme.button.copyWith(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
