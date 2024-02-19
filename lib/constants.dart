const kLoginScreen = 'login_screen';
const kHomeScreen = 'home_screen';
const baseURL = 'http://10.0.2.2:3001/';
bool validateEmail(String text) {
  if (RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(text)) {
    return true;
  } else {
    return false;
  }
}
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
