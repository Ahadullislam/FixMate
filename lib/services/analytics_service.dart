import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) async {
    await _analytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> logLogin({String? method}) async {
    await _analytics.logLogin(loginMethod: method);
  }

  Future<void> logSignUp({String? method}) async {
    await _analytics.logSignUp(signUpMethod: method ?? 'email');
  }

  Future<void> logBookingCreated({
    required String bookingId,
    required double amount,
  }) async {
    await _analytics.logEvent(
      name: 'booking_created',
      parameters: {'booking_id': bookingId, 'amount': amount},
    );
  }

  Future<void> setUserId(String userId) async {
    await _analytics.setUserId(id: userId);
  }
}
