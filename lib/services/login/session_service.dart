import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  String generateToken() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> saveSession() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', generateToken());
    final expiryDate = DateTime.now().add(const Duration(days: 30));

    await prefs.setString('expiryDate', expiryDate.toIso8601String());
  }

  Future<bool> loadSession() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final String? token = prefs.getString('token');
  final String? expiryDateString = prefs.getString('expiryDate');

  if (token != null && expiryDateString != null) {
    final expiryDate = DateTime.parse(expiryDateString);

    if (expiryDate.isAfter(DateTime.now())) {
      return true;
    }
  }
  return false;
}

}
