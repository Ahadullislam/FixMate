/// A model class representing a review in the FixMate app.
/// This class contains all the necessary information about a review
/// including the reviewer, provider, rating, and comments.
class ReviewModel {
  /// Unique identifier for the review
  final String id;

  /// ID of the user who wrote the review
  final String userId;

  /// ID of the provider being reviewed
  final String providerId;

  /// Rating given (1-5)
  final int rating;

  /// Review text/comment
  final String comment;

  /// List of photo URLs attached to the review
  final List<String>? photoUrls;

  /// Whether the review has been verified (e.g., confirmed booking)
  final bool isVerified;

  /// Creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.providerId,
    required this.rating,
    required this.comment,
    this.photoUrls,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates a ReviewModel from a JSON map
  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      providerId: json['providerId'] as String,
      rating: json['rating'] as int,
      comment: json['comment'] as String,
      photoUrls: json['photoUrls'] != null
          ? List<String>.from(json['photoUrls'] as List)
          : null,
      isVerified: json['isVerified'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  /// Converts the ReviewModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'providerId': providerId,
      'rating': rating,
      'comment': comment,
      'photoUrls': photoUrls,
      'isVerified': isVerified,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
