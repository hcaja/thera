import 'package:shared_preferences/shared_preferences.dart';

class Logout {
  Future<void> clinicLogout() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('clinicToken');
  }

  Future<void> employeeLogout() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('employeeToken');
  }

  Future<void> allLogout() async {
    late SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    await prefs.remove('employeeToken');
    await prefs.remove('clinicToken');
  }
}
