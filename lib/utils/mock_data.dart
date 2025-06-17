import '../models/provider.dart';
import '../models/service.dart';
import '../models/review.dart';
import '../models/booking.dart';
import '../models/user.dart';

/// A utility class that provides mock data for development and testing
class MockData {
  /// Returns a list of mock service providers
  static List<ProviderModel> getMockProviders() {
    return [
      ProviderModel(
        id: '1',
        name: 'John Smith',
        photoUrl: 'https://randomuser.me/api/portraits/men/1.jpg',
        skills: ['Plumbing', 'HVAC', 'General Repairs'],
        description: 'Professional plumber with 10 years of experience in residential and commercial plumbing services.',
        contact: '+1 (555) 123-4567',
        rating: 4.8,
        reviewIds: ['1', '2', '3'],
        portfolioImages: [
          'https://picsum.photos/200/300',
          'https://picsum.photos/200/301',
        ],
        isAvailable: true,
        hourlyRate: 75.0,
        yearsOfExperience: 10,
        certifications: ['Master Plumber', 'HVAC Certified'],
        serviceArea: 'New York City',
      ),
      ProviderModel(
        id: '2',
        name: 'Sarah Johnson',
        photoUrl: 'https://randomuser.me/api/portraits/women/1.jpg',
        skills: ['Electrical', 'Smart Home Installation'],
        description: 'Licensed electrician specializing in residential electrical work and smart home installations.',
        contact: '+1 (555) 234-5678',
        rating: 4.9,
        reviewIds: ['4', '5'],
        portfolioImages: [
          'https://picsum.photos/200/302',
          'https://picsum.photos/200/303',
        ],
        isAvailable: true,
        hourlyRate: 85.0,
        yearsOfExperience: 8,
        certifications: ['Master Electrician', 'Smart Home Certified'],
        serviceArea: 'Brooklyn',
      ),
    ];
  }

  /// Returns a list of mock services
  static List<ServiceModel> getMockServices() {
    return [
      ServiceModel(
        id: '1',
        name: 'Emergency Plumbing',
        category: 'plumbing',
        description: '24/7 emergency plumbing services for leaks, clogs, and other urgent issues.',
        basePrice: 150.0,
        isAvailable: true,
        requiredSkills: ['Plumbing', 'Emergency Response'],
        estimatedDuration: 2.0,
        examplePhotos: [
          'https://picsum.photos/200/304',
          'https://picsum.photos/200/305',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      ServiceModel(
        id: '2',
        name: 'Electrical Installation',
        category: 'electrical',
        description: 'Professional electrical installation services for new construction and renovations.',
        basePrice: 200.0,
        isAvailable: true,
        requiredSkills: ['Electrical', 'Installation'],
        estimatedDuration: 4.0,
        examplePhotos: [
          'https://picsum.photos/200/306',
          'https://picsum.photos/200/307',
        ],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  /// Returns a list of mock reviews
  static List<ReviewModel> getMockReviews() {
    return [
      ReviewModel(
        id: '1',
        userId: 'user1',
        providerId: '1',
        rating: 5,
        comment: 'Excellent service! Fixed my plumbing issue quickly and professionally.',
        photoUrls: ['https://picsum.photos/200/308'],
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      ReviewModel(
        id: '2',
        userId: 'user2',
        providerId: '1',
        rating: 4,
        comment: 'Good work, but a bit pricey.',
        isVerified: true,
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        updatedAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
    ];
  }

  /// Returns a list of mock bookings
  static List<BookingModel> getMockBookings() {
    return [
      BookingModel(
        id: '1',
        providerId: '1',
        userId: 'user1',
        bookingDateTime: DateTime.now().add(const Duration(days: 2)),
        duration: 2.0,
        status: BookingStatus.confirmed,
        notes: 'Please bring necessary tools for pipe replacement.',
        totalCost: 150.0,
        serviceType: 'Emergency Plumbing',
        serviceLocation: '123 Main St, New York, NY',
        paymentStatus: PaymentStatus.paid,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      BookingModel(
        id: '2',
        providerId: '2',
        userId: 'user1',
        bookingDateTime: DateTime.now().add(const Duration(days: 5)),
        duration: 4.0,
        status: BookingStatus.pending,
        totalCost: 200.0,
        serviceType: 'Electrical Installation',
        serviceLocation: '123 Main St, New York, NY',
        paymentStatus: PaymentStatus.pending,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  /// Returns a mock user
  static UserModel getMockUser() {
    return UserModel(
      id: 'user1',
      name: 'Alice Brown',
      email: 'alice@example.com',
      phone: '+1 (555) 987-6543',
      photoUrl: 'https://randomuser.me/api/portraits/women/2.jpg',
      address: '123 Main St, New York, NY',
      favoriteProviders: ['1', '2'],
      bookingIds: ['1', '2'],
      preferredPaymentMethod: 'Credit Card',
      notificationPreferences: NotificationPreferences(
        bookingConfirmations: true,
        bookingReminders: true,
        promotionalNotifications: false,
        providerUpdates: true,
      ),
      createdAt: DateTime.now().subtract(const Duration(days: 365)),
      updatedAt: DateTime.now(),
    );
  }
} 