import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'utils/auth_provider.dart';
import 'utils/theme.dart';
import 'pages/splash_page.dart';
import 'pages/onboarding_page.dart';
import 'pages/landing_page.dart';
import 'pages/service_list_page.dart';
import 'pages/service_details_page.dart';
import 'pages/service_providers_page.dart';
import 'pages/provider_profile_page.dart';
import 'pages/booking_flow_page.dart';
import 'pages/bookings_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/booking_details_page.dart';
import 'pages/chat_page.dart';
import 'pages/support_page.dart';
import 'pages/provider_registration_page.dart';
import 'pages/wallet_page.dart';
import 'pages/dashboard_page.dart';
import 'models/provider.dart';
import 'models/service.dart';
import 'models/booking.dart';
import 'models/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().initialize();
  // Optionally, you can await AnalyticsService() to ensure it's initialized
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const FixMateApp(),
    ),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode {
    if (_themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }
}

class FixMateApp extends StatelessWidget {
  const FixMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'FixMate',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeProvider.themeMode,
              initialRoute: '/splash',
              routes: {
                '/splash': (context) => const SplashPage(),
                '/onboarding': (context) => const OnboardingPage(),
                '/landing': (context) => const LandingPage(),
                '/services': (context) =>
                    const ServiceListPage(categoryLabel: ''),
                '/service-details': (context) {
                  final service =
                      ModalRoute.of(context)!.settings.arguments as Service;
                  return ServiceDetailsPage(service: service);
                },
                '/service-providers': (context) {
                  final service =
                      ModalRoute.of(context)!.settings.arguments as Service;
                  return ServiceProvidersPage(service: service);
                },
                '/provider': (context) {
                  final provider =
                      ModalRoute.of(context)!.settings.arguments
                          as ProviderModel;
                  return ProviderProfilePage(provider: provider);
                },
                '/booking': (context) {
                  final service =
                      ModalRoute.of(context)!.settings.arguments as Service;
                  return BookingFlowPage(service: service);
                },
                '/bookings': (context) => const BookingsPage(),
                '/booking-details': (context) {
                  final booking =
                      ModalRoute.of(context)!.settings.arguments
                          as BookingModel;
                  return BookingDetailsPage(booking: booking);
                },
                '/chat': (context) {
                  final recipient =
                      ModalRoute.of(context)!.settings.arguments as UserModel;
                  return ChatPage(recipient: recipient);
                },
                '/profile': (context) => const ProfilePage(),
                '/settings': (context) => const SettingsPage(),
                '/login': (context) => const LoginPage(),
                '/signup': (context) => const SignupPage(),
                '/dashboard': (context) => const DashboardPage(),
                '/support': (context) => const SupportPage(),
                '/provider-registration': (context) =>
                    const ProviderRegistrationPage(),
                '/wallet': (context) => const WalletPage(),
              },
            );
          },
        );
      },
    );
  }
}
