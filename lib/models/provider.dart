/// A model class representing a service provider in the FixMate app.
/// This class contains all the necessary information about a service provider
/// including their personal details, services, ratings, and portfolio.
class ProviderModel {
  /// Unique identifier for the provider
  final String id;

  /// Full name of the provider
  final String name;

  /// URL to the provider's profile photo
  final String photoUrl;

  /// List of services/skills offered by the provider
  final List<String> skills;

  /// Detailed description of the provider's experience and expertise
  final String description;

  /// Contact information (phone number, email)
  final String contact;

  /// Average rating of the provider (0.0 to 5.0)
  final double rating;

  /// List of review IDs associated with this provider
  final List<String> reviewIds;

  /// List of URLs to portfolio images
  final List<String> portfolioImages;

  /// Provider's availability status
  final bool isAvailable;

  /// Hourly rate for services
  final double hourlyRate;

  /// Years of experience
  final int yearsOfExperience;

  /// List of certifications
  final List<String> certifications;

  /// Location/area of service
  final String serviceArea;

  ProviderModel({
    required this.id,
    required this.name,
    required this.photoUrl,
    required this.skills,
    required this.description,
    required this.contact,
    required this.rating,
    required this.reviewIds,
    required this.portfolioImages,
    this.isAvailable = true,
    required this.hourlyRate,
    required this.yearsOfExperience,
    required this.certifications,
    required this.serviceArea,
  });

  /// Creates a ProviderModel from a JSON map
  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    return ProviderModel(
      id: json['id'] as String,
      name: json['name'] as String,
      photoUrl: json['photoUrl'] as String,
      skills: List<String>.from(json['skills'] as List),
      description: json['description'] as String,
      contact: json['contact'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewIds: List<String>.from(json['reviewIds'] as List),
      portfolioImages: List<String>.from(json['portfolioImages'] as List),
      isAvailable: json['isAvailable'] as bool? ?? true,
      hourlyRate: (json['hourlyRate'] as num).toDouble(),
      yearsOfExperience: json['yearsOfExperience'] as int,
      certifications: List<String>.from(json['certifications'] as List),
      serviceArea: json['serviceArea'] as String,
    );
  }

  /// Converts the ProviderModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photoUrl': photoUrl,
      'skills': skills,
      'description': description,
      'contact': contact,
      'rating': rating,
      'reviewIds': reviewIds,
      'portfolioImages': portfolioImages,
      'isAvailable': isAvailable,
      'hourlyRate': hourlyRate,
      'yearsOfExperience': yearsOfExperience,
      'certifications': certifications,
      'serviceArea': serviceArea,
    };
  }
}
