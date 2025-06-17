import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../utils/theme.dart';
import '../services/firestore_service.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart';
import '../models/booking.dart';
import '../models/provider.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  // final List<BookingModel> _allBookings = MockData.getMockBookings();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<AuthProvider>(context).firebaseUser?.uid;
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          'My Bookings',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Theme.of(context).textTheme.bodySmall?.color,
          labelStyle: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: const [
            Tab(text: 'Ongoing'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : StreamBuilder<List<BookingModel>>(
              stream: FirestoreService().getUserBookings(userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final allBookings = snapshot.data!;
                final ongoingBookings = allBookings
                    .where(
                      (booking) =>
                          booking.status == BookingStatus.pending ||
                          booking.status == BookingStatus.confirmed,
                    )
                    .toList();
                final completedBookings = allBookings
                    .where(
                      (booking) => booking.status == BookingStatus.completed,
                    )
                    .toList();
                return TabBarView(
                  controller: _tabController,
                  children: [
                    _buildBookingList(ongoingBookings),
                    _buildBookingList(completedBookings),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildBookingList(List<BookingModel> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Text(
          'No bookings found.',
          style: AppTheme.bodyLarge.copyWith(color: AppTheme.textLightColor),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        final providerId = booking.providerId;
        return FutureBuilder<ProviderModel?>(
          future: FirestoreService().getProvider(providerId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final provider = snapshot.data;
            if (provider == null) {
              return Center(
                child: Text(
                  'Provider not found.',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textLightColor,
                  ),
                ),
              );
            }
            return InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/booking-details',
                  arguments: booking,
                );
              },
              child: Card(
                color: AppTheme.darkSurfaceColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28.w,
                        backgroundImage: NetworkImage(provider.photoUrl),
                        onBackgroundImageError: (exception, stackTrace) {},
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
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
                            Text(
                              booking.serviceLocation,
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textLightColor,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'MMM dd, h:mm a',
                              ).format(booking.bookingDateTime),
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textLightColor,
                              ),
                            ),
                            Text(
                              'BDT ${booking.totalCost.toStringAsFixed(2)}',
                              style: AppTheme.bodySmall.copyWith(
                                color: AppTheme.textLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: booking.status == BookingStatus.completed
                              ? AppTheme.successColor
                              : AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          booking.status.name,
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
