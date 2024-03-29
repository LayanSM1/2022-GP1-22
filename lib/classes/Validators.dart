class Validators {
  /*static String? validateEmail(String? value) {
    const Pattern emailPatter =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    final regex = RegExp(emailPatter.toString());
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return 'Please enter a valid email';
    } else {
      return null;
    }
  }
*/




    String? validatePhone(String? value) {
    if(value == null || value.isEmpty  ){
      return 'Invalid Phone Number';
    }
  }
  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty || !value.contains('@') ){
      return 'Invalid Email';
    }
  }

  static String? validateEmailNew(String? value) {
    if(value == null || value.isEmpty || !value.contains('@') ){
      return 'Invalid Email';
    }
  }

  static String? validatePassword(String? value) {
    // const Pattern passwordPatter = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    // final regex = RegExp(passwordPatter.toString());
    // if (value!.isEmpty || !regex.hasMatch(value)) {


    if (value == null) return null;

    if (value.isEmpty) {
      return 'Enter password';
    }
    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }
    return null;
  }

  static String? validateConfirmPassword(String? value) {
    return null;
  }


  static String? validateUsername(String? value) {
    if (value == null) return null;
    if (value.isEmpty) {
      return 'Enter username';
    }
    if (value.length < 6) {
      return 'Username must contain at least 6 characters';
    }
    return null;
  }




}
