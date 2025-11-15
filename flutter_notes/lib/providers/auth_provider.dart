import 'package:flutter/foundation.dart';

class AuthProvider extends ChangeNotifier {
  bool _authenticated = false;
  bool get isAuthenticated => _authenticated;

  static const _username = 'admin';
  static const _password = 'admin123';

  Future<bool> login(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    if (username == _username && password == _password) {
      _authenticated = true;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _authenticated = false;
    notifyListeners();
  }
}
