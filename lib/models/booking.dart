/// A model class representing a booking in the FixMate app.
/// This class contains all the necessary information about a booking
/// including the provider, user, service details, and status.
class BookingModel {
  /// Unique identifier for the booking
  final String id;

  /// ID of the service provider
  final String providerId;

  /// ID of the user who made the booking
  final String userId;

  /// Date and time of the booking
  final DateTime bookingDateTime;

  /// Duration of the service in hours
  final double duration;

  /// Status of the booking (pending, confirmed, completed, cancelled)
  final BookingStatus status;

  /// Additional notes for the service provider
  final String? notes;

  /// Total cost of the booking
  final double totalCost;

  /// Service type/category
  final String serviceType;

  /// Location where the service will be provided
  final String serviceLocation;

  /// Payment status
  final PaymentStatus paymentStatus;

  /// Creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.providerId,
    required this.userId,
    required this.bookingDateTime,
    required this.duration,
    required this.status,
    this.notes,
    required this.totalCost,
    required this.serviceType,
    required this.serviceLocation,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a BookingModel from a JSON map
  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      providerId: json['providerId'] as String,
      userId: json['userId'] as String,
      bookingDateTime: DateTime.parse(json['bookingDateTime'] as String),
      duration: (json['duration'] as num).toDouble(),
      status: BookingStatus.values.firstWhere(
        (e) => e.toString() == 'BookingStatus.${json['status']}',
      ),
      notes: json['notes'] as String?,
      totalCost: (json['totalCost'] as num).toDouble(),
      serviceType: json['serviceType'] as String,
      serviceLocation: json['serviceLocation'] as String,
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.toString() == 'PaymentStatus.${json['paymentStatus']}',
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the BookingModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'providerId': providerId,
      'userId': userId,
      'bookingDateTime': bookingDateTime.toIso8601String(),
      'duration': duration,
      'status': status.toString().split('.').last,
      'notes': notes,
      'totalCost': totalCost,
      'serviceType': serviceType,
      'serviceLocation': serviceLocation,
      'paymentStatus': paymentStatus.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

/// Enum representing the possible statuses of a booking
enum BookingStatus { pending, confirmed, completed, cancelled }

/// Enum representing the possible payment statuses
enum PaymentStatus { pending, paid, refunded, failed }
