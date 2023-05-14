class Validators {
  static String? validateEmail(String? value) {
    const Pattern emailPatter =
    r'[a-z0-9]((\.|\+)?[a-z0-9]){5,}@g(oogle)?mail\.com$';
    final regex = RegExp(emailPatter.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }


  static String? validatePassword(String? value) {

    if (value == null) return null;

    if (value.isEmpty) {
      return 'Enter your password';
    }
    return null;
  }


  static String? validateUsername(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return 'Enter username';
    }
    if (value.length < 4) {
      return 'Username must contain at least 4 characters';
    }
    return null;
  }




}
