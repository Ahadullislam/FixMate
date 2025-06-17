import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';
import '../models/booking.dart';

class PaymentPage extends StatefulWidget {
  final BookingModel booking;

  const PaymentPage({super.key, required this.booking});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;

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
          'Choose Payment Method',
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
                'Service: ${widget.booking.serviceType}',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Theme.of(context).colorScheme.onBackground, fontSize: 24.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'Amount: BDT ${widget.booking.totalCost.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
              ),
              SizedBox(height: 32.h),
              Text(
                'Select a payment method',
                style: AppTheme.heading3.copyWith(color: Colors.white),
              ),
              SizedBox(height: 16.h),
              // Payment Options
              _buildPaymentMethodTile(
                title: 'SSLCOMMERZ',
                icon: Icons.credit_card,
                value: 'sslcommerz',
              ),
              SizedBox(height: 16.h),
              _buildPaymentMethodTile(
                title: 'bKash',
                icon: Icons.phone_android,
                value: 'bkash',
              ),
              SizedBox(height: 16.h),
              _buildPaymentMethodTile(
                title: 'Nagad',
                icon: Icons.phone_iphone,
                value: 'nagad',
              ),
              SizedBox(height: 16.h),
              _buildPaymentMethodTile(
                title: 'Credit/Debit Card',
                icon: Icons.payment,
                value: 'card',
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _selectedPaymentMethod == null
                      ? null
                      : () {
                          // TODO: Implement payment logic based on _selectedPaymentMethod
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Proceeding with ${_selectedPaymentMethod} payment for BDT ${widget.booking.totalCost.toStringAsFixed(2)}!',
                                style: AppTheme.bodyMedium.copyWith(
                                  color: AppTheme.successColor,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.borderRadiusSmall,
                                ),
                              ),
                              backgroundColor: AppTheme.darkSurfaceColor,
                            ),
                          );
                          Navigator.pop(
                            context,
                          ); // Go back after payment initiation
                        },
                  child: Text('Proceed to Pay', style: AppTheme.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile({
    required String title,
    required IconData icon,
    required String value,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: AppTheme.cardShadow,
      ),
      child: RadioListTile<String>(
        title: Text(
          title,
          style: AppTheme.bodyLarge.copyWith(color: Colors.white),
        ),
        secondary: Icon(icon, color: AppTheme.textLightColor, size: 28.w),
        value: value,
        groupValue: _selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            _selectedPaymentMethod = newValue;
          });
        },
        activeColor: AppTheme.primaryColor,
        tileColor: AppTheme.darkSurfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        ),
      ),
    );
  }
}
