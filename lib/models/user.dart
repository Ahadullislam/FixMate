/// A model class representing a user in the FixMate app.
/// This class contains all the necessary information about a user
/// including their personal details, preferences, and settings.
class UserModel {
  /// Unique identifier for the user
  final String id;

  /// User's full name
  final String name;

  /// User's email address
  final String email;

  /// User's phone number
  final String phone;

  /// URL to the user's profile photo
  final String? photoUrl;

  /// User's address
  final String? address;

  /// List of favorite provider IDs
  final List<String> favoriteProviders;

  /// List of booking IDs
  final List<String> bookingIds;

  /// User's preferred payment method
  final String? preferredPaymentMethod;

  /// User's notification preferences
  final NotificationPreferences notificationPreferences;

  /// Creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.photoUrl,
    this.address,
    required this.favoriteProviders,
    required this.bookingIds,
    this.preferredPaymentMethod,
    required this.notificationPreferences,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a UserModel from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      photoUrl: json['photoUrl'] as String?,
      address: json['address'] as String?,
      favoriteProviders: List<String>.from(json['favoriteProviders'] as List),
      bookingIds: List<String>.from(json['bookingIds'] as List),
      preferredPaymentMethod: json['preferredPaymentMethod'] as String?,
      notificationPreferences: NotificationPreferences.fromJson(
        json['notificationPreferences'] as Map<String, dynamic>,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photoUrl': photoUrl,
      'address': address,
      'favoriteProviders': favoriteProviders,
      'bookingIds': bookingIds,
      'preferredPaymentMethod': preferredPaymentMethod,
      'notificationPreferences': notificationPreferences.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// A class representing user notification preferences
class NotificationPreferences {
  /// Whether to receive booking confirmations
  final bool bookingConfirmations;

  /// Whether to receive booking reminders
  final bool bookingReminders;

  /// Whether to receive promotional notifications
  final bool promotionalNotifications;

  /// Whether to receive provider updates
  final bool providerUpdates;

  NotificationPreferences({
    required this.bookingConfirmations,
    required this.bookingReminders,
    required this.promotionalNotifications,
    required this.providerUpdates,
  });

  /// Creates NotificationPreferences from a JSON map
  factory NotificationPreferences.fromJson(Map<String, dynamic> json) {
    return NotificationPreferences(
      bookingConfirmations: json['bookingConfirmations'] as bool,
      bookingReminders: json['bookingReminders'] as bool,
      promotionalNotifications: json['promotionalNotifications'] as bool,
      providerUpdates: json['providerUpdates'] as bool,
    );
  }

  /// Converts NotificationPreferences to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'bookingConfirmations': bookingConfirmations,
      'bookingReminders': bookingReminders,
      'promotionalNotifications': promotionalNotifications,
      'providerUpdates': providerUpdates,
    };
  }
}
