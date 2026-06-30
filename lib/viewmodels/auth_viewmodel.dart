import 'package:flutter/material.dart';
import '../data/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> signInWithGoogle() async {
    _setLoading(true);
    _errorMessage = null;

    final result = await _authService.signInWithGoogle();
    
    _setLoading(false);
    
    if (result != null) {
      return true;
    } else {
      _errorMessage = 'Failed to sign in with Google.';
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
