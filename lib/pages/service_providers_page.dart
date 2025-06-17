import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/service.dart';
import '../models/provider.dart';
import '../services/firestore_service.dart';

class ServiceProvidersPage extends StatelessWidget {
  final Service service;

  const ServiceProvidersPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    // Filter providers based on service
    return StreamBuilder<List<ProviderModel>>(
      stream: FirestoreService().getProviders(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final providers = snapshot.data!
            .where((p) => p.skills.contains(service.category))
            .toList();
        return Scaffold(
          backgroundColor: const Color(0xFFF7F9FB),
          appBar: AppBar(
            title: Text(
              service.name,
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF24315E),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Color(0xFF24315E)),
          ),
          body: Column(
            children: [
              // Service info card
              Container(
                margin: EdgeInsets.all(16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      service.icon,
                      size: 40.w,
                      color: const Color(0xFF5893F4),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            service.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF24315E),
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            service.description,
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Provider list
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: providers.length,
                  itemBuilder: (context, index) {
                    final provider = providers[index];
                    return _buildProviderCard(context, provider);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProviderCard(BuildContext context, ProviderModel provider) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/provider', arguments: provider);
          },
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.r),
                  child: Image.network(
                    provider.photoUrl,
                    width: 80.w,
                    height: 80.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              provider.name,
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF24315E),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF5893F4),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 16.w,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  provider.rating.toString(),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 6.w,
                        children: provider.skills
                            .map(
                              (skill) => Chip(
                                label: Text(
                                  skill,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF5893F4),
                                  ),
                                ),
                                backgroundColor: const Color(0xFFE3ECFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16.w,
                            color: const Color(0xFFB0B6C3),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            provider.serviceArea,
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              color: const Color(0xFFB0B6C3),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '\$${provider.hourlyRate.toStringAsFixed(0)}/hr',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF5893F4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
