class Validation {
  String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? emity(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? towDegitValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^\d{2}$').hasMatch(value)) {
      return '2 digits required';
    }
    return null;
  }

  String? fourDegitValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return '4 digits required';
    }
    return null;
  }
  String? maxNumberValidation(String? value, int maxAllowed) {
    if (value == null || value.isEmpty) {
      return "Please enter a value";
    }
    final number = int.tryParse(value);
    if (number == null) {
      return "Enter a valid number";
    }
    if (number < 1) {
      return "Number must be at least 1";
    }
    if (number > maxAllowed) {
      return "Number must not be greater than $maxAllowed";
    }
    return null;
  }
  }

  String? nationalNumValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your national number';
    }
    if (value.length != 14) {
      return 'National number must be 14 digits';
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? phoneNumberValidator(String? phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return 'Please enter a valid phone number';
    }

    // Check if the phone number length is 11
    if (phoneNumber.length != 11) {
      return "11 number required";
    }

    // Check if the phone number starts with valid prefixes
    if (!RegExp(r'^(011|012|010|015)\d{8}$').hasMatch(phoneNumber)) {
      return 'not valid phone number';
    }

    return null;
  }

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  String? validateDay(String? value) {
    if (value == null || value.isEmpty) {
      return 'Day is required';
    }
    if (!RegExp(r'^\d{2}$').hasMatch(value)) {
      return 'Day must be 2 digits';
    }
    int day = int.parse(value);
    if (day < 1 || day > 31) {
      return 'Day must be between 01 and 31';
    }
    return null;
  }

  String? validateMonth(String? value) {
    if (value == null || value.isEmpty) {
      return 'Month is required';
    }
    if (!RegExp(r'^\d{2}$').hasMatch(value)) {
      return 'Month must be 2 digits';
    }
    int month = int.parse(value);
    if (month < 1 || month > 12) {
      return 'Month must be between 01 and 12';
    }
    return null;
  }

  String? validateYear(String? value) {
    if (value == null || value.isEmpty) {
      return 'Year is required';
    }
    if (!RegExp(r'^\d{4}$').hasMatch(value)) {
      return 'Year must be 4 digits';
    }
    int year = int.parse(value);
    if (year < 1900 || year > DateTime.now().year) {
      return 'Year must be between 1900 and the current year';
    }
    return null;
  }

