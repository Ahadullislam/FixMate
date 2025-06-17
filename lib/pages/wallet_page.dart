import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Wallet',
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
              _buildBalanceCard(context),
              SizedBox(height: 24.h),
              Text(
                'Recent Transactions',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.onBackground),
              ),
              SizedBox(height: 16.h),
              _buildTransactionList(),
              SizedBox(height: 24.h),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to add funds page
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Add Funds functionality coming soon!',
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  textStyle: AppTheme.button,
                ),
                child: Center(
                  child: Text(
                    'Add Funds',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: AppTheme.cardShadow,
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Balance',
            style: AppTheme.bodyLarge.copyWith(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '\$250.00', // Placeholder balance
            style: AppTheme.heading1.copyWith(
              color: Colors.white,
              fontSize: 36.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Last updated: Oct 26, 2023', // Placeholder date
              style: AppTheme.bodySmall.copyWith(
                color: Colors.white.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionList() {
    // Placeholder for transaction data
    final List<Map<String, String>> transactions = [
      {
        'title': 'Service Payment',
        'amount': '-\$50.00',
        'date': 'Oct 25, 2023',
      },
      {'title': 'Top-up', 'amount': '+\$100.00', 'date': 'Oct 20, 2023'},
      {
        'title': 'Service Payment',
        'amount': '-\$30.00',
        'date': 'Oct 18, 2023',
      },
      {'title': 'Referral Bonus', 'amount': '+\$10.00', 'date': 'Oct 15, 2023'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.darkSurfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            boxShadow: AppTheme.cardShadow,
          ),
          child: Row(
            children: [
              Icon(
                transaction['amount']!.startsWith('+')
                    ? Icons.add_circle
                    : Icons.remove_circle,
                color: transaction['amount']!.startsWith('+')
                    ? AppTheme.successColor
                    : AppTheme.errorColor,
                size: 28.w,
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['title']!,
                      style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      transaction['date']!,
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textLightColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                transaction['amount']!,
                style: AppTheme.bodyLarge.copyWith(
                  color: transaction['amount']!.startsWith('+')
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
