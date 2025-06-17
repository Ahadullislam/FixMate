import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../utils/theme.dart';
import 'package:provider/provider.dart';
import '../utils/auth_provider.dart' as local_auth;
import '../widgets/main_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.trim();
      final pass = _passwordController.text.trim();
      final authProvider = Provider.of<local_auth.AuthProvider>(context, listen: false);
      final error = await authProvider.login(email, pass);
      if (error == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainNavigation()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Back button
                IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    )
                    .animate()
                    .fadeIn(duration: 600.ms)
                    .slideX(begin: -0.2, end: 0, duration: 600.ms),

                SizedBox(height: 20.h),

                // Login text
                Text(
                      'Login',
                      style: AppTheme.heading1.copyWith(fontSize: 32.sp),
                    )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 600.ms)
                    .slideX(
                      begin: -0.2,
                      end: 0,
                      delay: 200.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 40.h),

                // Email input
                TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    )
                    .animate()
                    .fadeIn(delay: 400.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 400.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 24.h),

                // Password input
                TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    )
                    .animate()
                    .fadeIn(delay: 600.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 600.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 12.h),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password logic
                    },
                    child: Text(
                      'Forgot password?',
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ).animate().fadeIn(delay: 700.ms, duration: 600.ms),

                SizedBox(height: 32.h),

                // Continue with Google button
                SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final authProvider = Provider.of<local_auth.AuthProvider>(context, listen: false);
                          final error = await authProvider.loginWithGoogle();
                          if (error == null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainNavigation()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(error), backgroundColor: Colors.redAccent),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.g_mobiledata,
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.primaryColor
                              : Colors.white,
                        ),
                        label: Text(
                          'Continue with Google',
                          style: AppTheme.button.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                ? AppTheme.primaryColor
                                : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.surfaceColor
                              : AppTheme.darkSurfaceColor,
                          foregroundColor:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.primaryColor
                              : Colors.white,
                          side: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.borderRadius,
                            ),
                          ),
                          elevation: 0,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 800.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 800.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 16.h),

                // Continue with Phone button
                SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // TODO: Implement phone login
                        },
                        icon: Icon(
                          Icons.phone,
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.primaryColor
                              : Colors.white,
                        ),
                        label: Text(
                          'Continue with Phone',
                          style: AppTheme.button.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                ? AppTheme.primaryColor
                                : Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.surfaceColor
                              : AppTheme.darkSurfaceColor,
                          foregroundColor:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.primaryColor
                              : Colors.white,
                          side: BorderSide(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.borderRadius,
                            ),
                          ),
                          elevation: 0,
                        ),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 900.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 900.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 24.h),

                // Or divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppTheme.textLightColor.withOpacity(0.3),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Or',
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textLightColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppTheme.textLightColor.withOpacity(0.3),
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),

                SizedBox(height: 24.h),

                // Login button (Continue with Email)
                SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onLoginPressed,
                        child: Text('Login', style: AppTheme.button),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 1100.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 1100.ms,
                      duration: 600.ms,
                    ),

                SizedBox(height: 24.h),

                // Sign up link
                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textLightColor,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            'Sign Up',
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    )
                    .animate()
                    .fadeIn(delay: 1200.ms, duration: 600.ms)
                    .slideY(
                      begin: 0.3,
                      end: 0,
                      delay: 1200.ms,
                      duration: 600.ms,
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
