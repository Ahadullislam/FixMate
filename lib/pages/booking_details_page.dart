import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import '../models/booking.dart';
import 'package:intl/intl.dart';

class BookingDetailsPage extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailsPage({super.key, required this.booking});

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
          'Booking Details',
          style: AppTheme.heading3.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location Map Placeholder
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Center(
                  child: Icon(
                    Icons.map,
                    size: 80.w,
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ), // TODO: Integrate Google Maps
              ),
              SizedBox(height: 24.h),

              // Address Details
              Text(
                'Address',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppTheme.primaryColor,
                          size: 20.w,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            booking.serviceLocation,
                            style: AppTheme.bodyLarge.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Booking Details
              Text(
                'Booking Details',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppTheme.darkSurfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Service:',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            booking.serviceType,
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Date:',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            DateFormat(
                              'yyyy-MM-dd',
                            ).format(booking.bookingDateTime),
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Time:',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            DateFormat(
                              'hh:mm a',
                            ).format(booking.bookingDateTime),
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          'Status:',
                          style: AppTheme.bodyLarge.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            booking.status.toString().split('.').last,
                            style: AppTheme.bodyLarge.copyWith(
                              color: AppTheme.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Cancel Booking Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Implement cancel booking logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.errorColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                    ),
                  ),
                  child: Text(
                    'Cancel Booking',
                    style: AppTheme.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
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
}
