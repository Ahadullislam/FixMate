import 'package:flutter/material.dart';

/// A model class representing a service in the FixMate app.
/// This class contains all the necessary information about a service
/// including its category, description, and pricing.
class ServiceModel {
  /// Unique identifier for the service
  final String id;

  /// Name of the service
  final String name;

  /// Category of the service (e.g., Plumbing, Electrical, Cleaning)
  final String category;

  /// Detailed description of the service
  final String description;

  /// Base price for the service
  final double basePrice;

  /// Whether the service is available
  final bool isAvailable;

  /// List of required skills for this service
  final List<String> requiredSkills;

  /// Estimated duration in hours
  final double estimatedDuration;

  /// List of photo URLs showing examples of the service
  final List<String>? examplePhotos;

  /// Creation timestamp
  final DateTime createdAt;

  /// Last update timestamp
  final DateTime updatedAt;

  /// Optional icon representing the service
  final IconData? icon;

  ServiceModel({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.basePrice,
    required this.isAvailable,
    required this.requiredSkills,
    required this.estimatedDuration,
    this.examplePhotos,
    required this.createdAt,
    required this.updatedAt,
    this.icon,
  });

  /// Creates a ServiceModel from a JSON map
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      basePrice: (json['basePrice'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
      requiredSkills: List<String>.from(json['requiredSkills'] as List),
      estimatedDuration: (json['estimatedDuration'] as num).toDouble(),
      examplePhotos: json['examplePhotos'] != null
          ? List<String>.from(json['examplePhotos'] as List)
          : null,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      icon: json['icon'] != null
          ? IconData(json['icon'], fontFamily: 'MaterialIcons')
          : null,
    );
  }

  /// Converts the ServiceModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'basePrice': basePrice,
      'isAvailable': isAvailable,
      'requiredSkills': requiredSkills,
      'estimatedDuration': estimatedDuration,
      'examplePhotos': examplePhotos,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'icon': icon?.codePoint,
    };
  }
}

/// Enum representing the main service categories
enum ServiceCategory {
  plumbing,
  electrical,
  cleaning,
  carpentry,
  painting,
  gardening,
  hvac,
  locksmith,
  pestControl,
  other,
}

class Service {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final String imageUrl;
  final List<String> tags;
  final double basePrice;
  final String category;

  const Service({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.imageUrl,
    required this.tags,
    required this.basePrice,
    required this.category,
  });
}

// Mock data for services
class ServiceData {
  static List<Service> getServices() {
    return [
      Service(
        id: 'plumbing',
        name: 'Plumbing Services',
        description: 'Professional plumbing services for your home and office needs.',
        icon: Icons.plumbing,
        imageUrl: 'https://images.unsplash.com/photo-1607472586893-edb57bdc0e39',
        tags: ['Plumbing', 'Drainage', 'Water Heater', 'Pipe Repair'],
        basePrice: 50.0,
        category: 'Home Services',
      ),
      Service(
        id: 'electrical',
        name: 'Electrical Services',
        description: 'Expert electrical repairs and installations.',
        icon: Icons.electrical_services,
        imageUrl: 'https://images.unsplash.com/photo-1621905251189-08b45d6a269e',
        tags: ['Electrical', 'Wiring', 'Lighting', 'Repairs'],
        basePrice: 60.0,
        category: 'Home Services',
      ),
      Service(
        id: 'cleaning',
        name: 'Cleaning Services',
        description: 'Professional cleaning services for your space.',
        icon: Icons.cleaning_services,
        imageUrl: 'https://images.unsplash.com/photo-1581578731548-c64695cc6952',
        tags: ['Cleaning', 'Deep Clean', 'Move-out', 'Regular'],
        basePrice: 40.0,
        category: 'Home Services',
      ),
      Service(
        id: 'carpentry',
        name: 'Carpentry Services',
        description: 'Custom woodwork and furniture repairs.',
        icon: Icons.handyman,
        imageUrl: 'https://images.unsplash.com/photo-1504917595217-d4dc5ebe6122',
        tags: ['Carpentry', 'Furniture', 'Repairs', 'Custom'],
        basePrice: 55.0,
        category: 'Home Services',
      ),
      Service(
        id: 'painting',
        name: 'Painting Services',
        description: 'Professional painting for interior and exterior.',
        icon: Icons.format_paint,
        imageUrl: 'https://images.unsplash.com/photo-1560439514-4e9645039924',
        tags: ['Painting', 'Interior', 'Exterior', 'Renovation'],
        basePrice: 45.0,
        category: 'Home Services',
      ),
      Service(
        id: 'gardening',
        name: 'Gardening Services',
        description: 'Landscaping and garden maintenance.',
        icon: Icons.landscape,
        imageUrl: 'https://images.unsplash.com/photo-1558904541-efa843a96f01',
        tags: ['Gardening', 'Landscaping', 'Maintenance', 'Design'],
        basePrice: 35.0,
        category: 'Home Services',
      ),
      Service(
        id: 'hvac',
        name: 'HVAC Services',
        description: 'Heating, ventilation, and air conditioning services.',
        icon: Icons.ac_unit,
        imageUrl: 'https://images.unsplash.com/photo-1581093458791-9d15482442f6',
        tags: ['HVAC', 'AC Repair', 'Heating', 'Installation'],
        basePrice: 70.0,
        category: 'Home Services',
      ),
      Service(
        id: 'locksmith',
        name: 'Locksmith Services',
        description: '24/7 locksmith and security services.',
        icon: Icons.lock,
        imageUrl: 'https://images.unsplash.com/photo-1558002038-1055907df827',
        tags: ['Locksmith', 'Security', 'Emergency', 'Installation'],
        basePrice: 65.0,
        category: 'Home Services',
      ),
    ];
  }
}
