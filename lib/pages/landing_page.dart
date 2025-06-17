import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/provider.dart';
import '../utils/mock_data.dart';
// Ensure that mockProviders is defined and exported from mock_data.dart as a List<ProviderModel>
import '../utils/theme.dart';
import '../widgets/provider_card.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo or Illustration
              Icon(
                    Icons.home_repair_service,
                    size: 150.w,
                    color: AppTheme.primaryColor,
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(delay: 200.ms, duration: 600.ms),

              SizedBox(height: 40.h),

              // Welcome Message
              Text(
                    'Your Ultimate Home Service Solution',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge?.copyWith(fontSize: 28.sp),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 600.ms),

              SizedBox(height: 16.h),

              Text(
                    'Find trusted professionals for all your needs.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
                    textAlign: TextAlign.center,
                  )
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),

              SizedBox(height: 60.h),

              // Buttons
              SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Text('Log In', style: AppTheme.button),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 800.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 800.ms, duration: 600.ms),

              SizedBox(height: 16.h),

              SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Sign Up',
                        style: AppTheme.button.copyWith(
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 1000.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 1000.ms, duration: 600.ms),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Use FirestoreService().getProviders() stream for provider list.
  final TextEditingController _searchController = TextEditingController();

  // Temporary mock provider list
  final List<ProviderModel> _providers = MockData.getMockProviders();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onProviderCardTap(ProviderModel provider) {
    Navigator.pushNamed(context, '/provider', arguments: provider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App bar
            SliverAppBar(
              floating: true,
              title: Text(
                'FixMate',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontSize: 24.sp,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // TODO: Implement notifications
                  },
                ),
              ],
            ),
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search for services...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
            // Categories
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    _buildCategoryCard(
                      icon: Icons.plumbing,
                      label: 'Plumbing',
                      onTap: () {
                        // TODO: Filter by category
                      },
                    ),
                    _buildCategoryCard(
                      icon: Icons.electrical_services,
                      label: 'Electrical',
                      onTap: () {
                        // TODO: Filter by category
                      },
                    ),
                    _buildCategoryCard(
                      icon: Icons.cleaning_services,
                      label: 'Cleaning',
                      onTap: () {
                        // TODO: Filter by category
                      },
                    ),
                    _buildCategoryCard(
                      icon: Icons.carpenter,
                      label: 'Carpentry',
                      onTap: () {
                        // TODO: Filter by category
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Provider list
            SliverPadding(
              padding: EdgeInsets.all(16.w),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final provider = _providers[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: ProviderCard(
                      provider: provider,
                      onTap: () => _onProviderCardTap(provider),
                    ),
                  );
                }, childCount: _providers.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 80.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32.w, color: AppTheme.primaryColor),
              SizedBox(height: 8.h),
              Text(
                label,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
