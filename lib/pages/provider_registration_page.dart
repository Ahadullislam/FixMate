import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/theme.dart';

class ProviderRegistrationPage extends StatefulWidget {
  const ProviderRegistrationPage({super.key});

  @override
  State<ProviderRegistrationPage> createState() =>
      _ProviderRegistrationPageState();
}

class _ProviderRegistrationPageState extends State<ProviderRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _serviceTypeController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  String? _selectedServiceCategory;
  List<String> _serviceCategories = [
    'Plumbing',
    'Electrician',
    'Cleaning',
    'Appliance Repair',
    'Painting',
    'Carpentry',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _serviceTypeController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void _registerProvider() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement provider registration logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Provider registration submitted!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.successColor),
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSmall),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      );
      // Navigate back or to a success page
      Navigator.pop(context);
    }
  }

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
          'Become a Service Provider',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Join our network of professionals.',
                  style: AppTheme.heading2.copyWith(
                    color: Colors.white,
                    fontSize: 24.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Fill out the form below to register as a service provider.',
                  style: AppTheme.bodyLarge.copyWith(
                    color: AppTheme.textLightColor,
                  ),
                ),
                SizedBox(height: 32.h),
                TextField(
                  controller: _nameController,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _emailController,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _phoneController,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Phone Number',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _addressController,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Service Area Address',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: 'Select Service Category',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                  dropdownColor: AppTheme.darkSurfaceColor,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  value: _selectedServiceCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedServiceCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a service category';
                    }
                    return null;
                  },
                  items: _serviceCategories.map<DropdownMenuItem<String>>((
                    String value,
                  ) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.h),
                TextField(
                  controller: _experienceController,
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Years of Experience',
                    hintStyle: AppTheme.bodyLarge.copyWith(
                      color: AppTheme.textLightColor,
                    ),
                    filled: true,
                    fillColor: AppTheme.darkSurfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 15.h,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Upload Documents (e.g., ID, Certifications)',
                  style: AppTheme.bodyLarge.copyWith(color: Colors.white),
                ),
                SizedBox(height: 8.h),
                // TODO: Implement file upload functionality
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.darkSurfaceColor,
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        size: 40.w,
                        color: AppTheme.textLightColor,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Tap to upload files',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  onPressed: _registerProvider,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadius,
                      ),
                    ),
                    textStyle: AppTheme.button.copyWith(fontSize: 18.sp),
                  ),
                  child: Text(
                    'Register',
                    style: AppTheme.button.copyWith(fontSize: 18.sp),
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
