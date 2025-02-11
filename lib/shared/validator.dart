part of 'shared.dart';

String? firstNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'First name filed can\'t be empty.';
  } else {
    return null;
  }
}

String? lastNameValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Last name filed can\'t be empty.';
  } else {
    return null;
  }
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email filed can\'t be empty.';
  } else if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)) {
    return "Please enter a valid email address";
  } else {
    return null;
  }
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password filed can\'t be empty.';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters.';
  } else {
    return null;
  }
}

String? confirmPasswordValidator(
    String? value, TextEditingController passwordController) {
  if (value == null || value.isEmpty) {
    return 'Confirm password filed can\'t be empty.';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters.';
  } else if (value != passwordController.text) {
    return "Password field and confirm password field must be the same.";
  } else {
    return null;
  }
}

String? titleValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Title filed can\'t be empty.';
  } else {
    return null;
  }
}
