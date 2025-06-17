import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreService _firestoreService = FirestoreService();

  User? _firebaseUser;
  UserModel? _userModel;
  bool _isLoading = false;

  bool get isLoggedIn => _firebaseUser != null;
  User? get firebaseUser => _firebaseUser;
  UserModel? get userModel => _userModel;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _authService.authStateChanges.listen((user) async {
      _firebaseUser = user;
      if (user != null) {
        _userModel = await _firestoreService.getUser(user.uid);
      } else {
        _userModel = null;
      }
      notifyListeners();
    });
  }

  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        _firebaseUser = user;
        _userModel = await _firestoreService.getUser(user.uid);
        return null;
      }
      return 'Login failed.';
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signUpWithEmail(email, password);
      if (user != null) {
        final userModel = UserModel(
          id: user.uid,
          name: name,
          email: email,
          phone: phone,
          photoUrl: null,
          address: null,
          favoriteProviders: [],
          bookingIds: [],
          preferredPaymentMethod: null,
          notificationPreferences: NotificationPreferences(
            bookingConfirmations: true,
            bookingReminders: true,
            promotionalNotifications: true,
            providerUpdates: true,
          ),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        await _firestoreService.createUser(userModel);
        _firebaseUser = user;
        _userModel = userModel;
        return null;
      }
      return 'Signup failed.';
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String?> loginWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _authService.signInWithGoogle();
      if (user != null) {
        _firebaseUser = user;
        _userModel = await _firestoreService.getUser(user.uid);
        // If user doc doesn't exist, create it
        if (_userModel == null) {
          final userModel = UserModel(
            id: user.uid,
            name: user.displayName ?? '',
            email: user.email ?? '',
            phone: user.phoneNumber ?? '',
            photoUrl: user.photoURL,
            address: null,
            favoriteProviders: [],
            bookingIds: [],
            preferredPaymentMethod: null,
            notificationPreferences: NotificationPreferences(
              bookingConfirmations: true,
              bookingReminders: true,
              promotionalNotifications: true,
              providerUpdates: true,
            ),
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          await _firestoreService.createUser(userModel);
          _userModel = userModel;
        }
        return null;
      }
      return 'Google sign-in failed.';
    } catch (e) {
      return e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    _firebaseUser = null;
    _userModel = null;
    notifyListeners();
  }

  Future<void> updateProfilePhoto(String url) async {
    if (_firebaseUser != null) {
      await _firestoreService.updateUserPhoto(_firebaseUser!.uid, url);
      if (_userModel != null) {
        _userModel = UserModel(
          id: _userModel!.id,
          name: _userModel!.name,
          email: _userModel!.email,
          phone: _userModel!.phone,
          photoUrl: url,
          address: _userModel!.address,
          favoriteProviders: _userModel!.favoriteProviders,
          bookingIds: _userModel!.bookingIds,
          preferredPaymentMethod: _userModel!.preferredPaymentMethod,
          notificationPreferences: _userModel!.notificationPreferences,
          createdAt: _userModel!.createdAt,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
      }
    }
  }
}
