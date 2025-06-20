import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/provider.dart';
import '../services/firestore_service.dart';
import '../utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  String? userName;
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;

  // List<ProviderModel> _providers = MockData.getMockProviders();

  @override
  void initState() {
    super.initState();
    _fetchUserAndCategories();
  }

  Future<void> _fetchUserAndCategories() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        userName = doc.data()?['name'] ?? '';
      }
      // Fetch categories from Firestore
      final catSnapshot = await FirebaseFirestore.instance
          .collection('categories')
          .get();
      categories = catSnapshot.docs.map((doc) {
        return {'icon': _iconFromString(doc['icon']), 'label': doc['label']};
      }).toList();
    } catch (e) {
      // fallback to empty or default
      categories = [];
    }
    setState(() {
      isLoading = false;
    });
  }

  IconData _iconFromString(String iconName) {
    // Map string to Icons. Add more as needed.
    switch (iconName) {
      case 'electrical_services':
        return Icons.electrical_services;
      case 'plumbing':
        return Icons.plumbing;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'carpenter':
        return Icons.carpenter;
      case 'format_paint':
        return Icons.format_paint;
      case 'pest_control':
        return Icons.pest_control;
      case 'local_shipping':
        return Icons.local_shipping;
      case 'cleaning_services':
        return Icons.cleaning_services;
      default:
        return Icons.category;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              // App Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                    Text(
                      'FixMate',
                      style: AppTheme.heading2.copyWith(color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      color: Colors.white,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              // Welcome Text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: isLoading
                    ? const SizedBox(
                        height: 40,
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Text(
                        'Hello,  24{userName ?? "User"}',
                        style: AppTheme.heading1.copyWith(color: Colors.white),
                      ),
              ),
              SizedBox(height: 24.h),
              // Categories Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Categories',
                  style: AppTheme.heading3.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.h),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final cat = categories[index];
                      return _buildCategoryCard(
                        icon: cat['icon'] as IconData,
                        label: cat['label'] as String,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/services',
                            arguments: cat['label'],
                          );
                        },
                      );
                    },
                  ),
                ),
              SizedBox(height: 32.h),
              // Popular Services Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  'Popular Services',
                  style: AppTheme.heading3.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                height: 200.h,
                child: StreamBuilder<List<ProviderModel>>(
                  stream: FirestoreService().getProviders(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final providers = snapshot.data!;
                    if (providers.isEmpty) {
                      return Center(
                        child: Text('No providers found.', style: AppTheme.bodyLarge.copyWith(color: Colors.white)),
                      );
                    }
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      itemCount: providers.length,
                      itemBuilder: (context, index) {
                        final provider = providers[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: _buildServiceCard(provider),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.darkSurfaceColor,
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32.w, color: AppTheme.primaryColor),
            SizedBox(height: 8.h),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(ProviderModel provider) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
        color: AppTheme.darkSurfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppTheme.borderRadius),
            ),
            child: Image.network(
              provider.photoUrl,
              height: 100.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  provider.skills.join(', '),
                  style: AppTheme.bodyMedium.copyWith(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  'From BDT 500.00', // Placeholder price
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textLightColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
