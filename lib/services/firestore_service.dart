import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';
import '../models/provider.dart';
import '../models/booking.dart';
import '../models/message.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // USER
  Future<void> createUser(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toJson());
  }

  Future<UserModel?> getUser(String userId) async {
    final doc = await _db.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }

  Stream<UserModel?> userStream(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => snap.exists ? UserModel.fromJson(snap.data()!) : null);
  }

  Future<void> updateUserPhoto(String userId, String photoUrl) async {
    await _db.collection('users').doc(userId).update({'photoUrl': photoUrl});
  }

  // PROVIDER
  Future<void> createProvider(ProviderModel provider) async {
    await _db.collection('providers').doc(provider.id).set(provider.toJson());
  }

  Future<ProviderModel?> getProvider(String providerId) async {
    final doc = await _db.collection('providers').doc(providerId).get();
    if (doc.exists) {
      return ProviderModel.fromJson(doc.data()!);
    }
    return null;
  }

  Stream<List<ProviderModel>> getProviders() {
    return _db
        .collection('providers')
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => ProviderModel.fromJson(d.data())).toList(),
        );
  }

  Stream<ProviderModel?> getProviderStream(String providerId) {
    return _db
        .collection('providers')
        .doc(providerId)
        .snapshots()
        .map(
          (snap) => snap.exists ? ProviderModel.fromJson(snap.data()!) : null,
        );
  }

  // BOOKINGS
  Future<void> createBooking(BookingModel booking) async {
    await _db.collection('bookings').doc(booking.id).set(booking.toJson());
  }

  Stream<List<BookingModel>> getUserBookings(String userId) {
    return _db
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map(
          (snap) =>
              snap.docs.map((d) => BookingModel.fromJson(d.data())).toList(),
        );
  }

  // MESSAGES
  Future<void> sendMessage(Message message) async {
    await _db.collection('messages').add(message.toJson());
  }

  Stream<List<Message>> getChatMessages(String chatId) {
    return _db
        .collection('messages')
        .where('chatId', isEqualTo: chatId)
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snap) => snap.docs.map((d) => Message.fromJson(d.data())).toList(),
        );
  }
}
