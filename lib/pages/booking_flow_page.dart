import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import '../models/service.dart';

class BookingFlowPage extends StatefulWidget {
  final Service service;
  const BookingFlowPage({super.key, required this.service});

  @override
  State<BookingFlowPage> createState() => _BookingFlowPageState();
}

class _BookingFlowPageState extends State<BookingFlowPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _confirmBooking(Service service) {
    if (_selectedDate == null ||
        _selectedTime == null ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please select date, time and enter address.',
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.errorColor),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          backgroundColor: AppTheme.darkSurfaceColor,
        ),
      );
      return;
    }
    // TODO: Implement actual booking logic (e.g., send to Firebase)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking confirmed for ${service.name}!',
          style: AppTheme.bodyMedium.copyWith(color: AppTheme.successColor),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
        ),
        backgroundColor: AppTheme.darkSurfaceColor,
      ),
    );
    Navigator.pop(context); // Go back to service details or home
  }

  @override
  Widget build(BuildContext context) {
    final service = widget.service;

    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.darkBackgroundColor,
        title: Text(
          'Book Service',
          style: AppTheme.heading3.copyWith(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service: ${service.name}',
                style: AppTheme.heading2.copyWith(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Price: BDT ${service.basePrice.toStringAsFixed(2)}',
                style: AppTheme.bodyLarge.copyWith(
                  color: AppTheme.textLightColor,
                ),
              ),
              SizedBox(height: 32.h),
              // Date Selection
              Text(
                'Select Date',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.darkSurfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate == null
                            ? 'Choose Date'
                            : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                        style: AppTheme.bodyLarge.copyWith(
                          color: _selectedDate == null
                              ? AppTheme.textLightColor
                              : Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.calendar_today,
                        color: AppTheme.textLightColor,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // Time Selection
              Text(
                'Select Time',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              InkWell(
                onTap: () => _selectTime(context),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.darkSurfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    boxShadow: AppTheme.cardShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedTime == null
                            ? 'Choose Time'
                            : _selectedTime!.format(context),
                        style: AppTheme.bodyLarge.copyWith(
                          color: _selectedTime == null
                              ? AppTheme.textLightColor
                              : Colors.white,
                        ),
                      ),
                      Icon(Icons.access_time, color: AppTheme.textLightColor),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              // Address Input
              Text(
                'Enter Address',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              TextFormField(
                controller: _addressController,
                style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Your service address',
                  hintStyle: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textLightColor,
                  ),
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: AppTheme.textLightColor,
                  ),
                  filled: true,
                  fillColor: AppTheme.darkSurfaceColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                    borderSide: const BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 32.h),
              // Confirm Booking Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _confirmBooking(service),
                  child: Text('Confirm Booking', style: AppTheme.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
