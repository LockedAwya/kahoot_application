import 'package:regexpattern/regexpattern.dart';

class ValidateUtil {
  static bool isEmail(String? em) {
    if (em == null) return false;
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  static bool isNumber(String value) {
    RegExp regExp = RegExp(r'^[0-9]*$');
    return regExp.hasMatch(value);
  }

  static bool isPasswordSecure(String value) {
    if (value.isEmpty) {
      return false;
    }
    //(?<!\d)\d{4,}(?!\d)
    //r'^(?=.*[a-zA-Z]{3,})(?=.*[0-9])(?=.*[!@#\$%\^&\*])(?=.{8,20})(?!\d{4,})(?!\[!@#\$%\^&]{4,})',
    RegExp regExp = RegExp(
      //r'^\S*(?=\S{8,20})(?=((?!S*[\d]{4,}).)(?=\S*[a-zA-Z]){3,})(?=\S*[\d])(?=\S*[\W])\S*$',
      r'^(?=.*[a-zA-Z]{3,})(?=.*[0-9])(?=.*[\(\)\\|!@#\/$%\^&\*+\+\-\=\_\?\>\<\.\,\]\[\{\}\~\`])(?!.*(.)\1{3,})(?!.*(1234|2345|3456|4567|5678|6789|9876|8765|7654|6543|5432|4321)).{8,20}$',
      caseSensitive: false,
      multiLine: false,
    );

    if (!regExp.hasMatch(value)) {
      return false;
    }

    return true;
  }

  static int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  static bool doesGreatEqualThan14Years(DateTime dateSelected) {
    // check >14 year old
    if (calculateAge(dateSelected) >= 14) {
      return true;
    }
    return false;
  }

  static bool isPhoneValid(String value) {
    if (value.contains(RegExp(r'[A-Z]')) || value.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    return true;
  }

  static bool isPhoneUser(String phone) {
    if (RegVal.hasMatch(phone, RegexPattern.phone)) {
      return true;
    }
    return false;
  }

  static bool isPasswordAndConfirmPasswordMatch(
      String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    }
    return false;
  }

  static bool isNameUser(String? value) {
    if (value != null && RegVal.hasMatch(value, RegexPattern.username)) {
      return true;
    }
    return false;
  }

  static bool isPassUser(String? value) {
    if (value != null && RegVal.hasMatch(value, RegexPattern.passport)) {
      return true;
    }
    return false;
  }
}
