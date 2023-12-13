import 'package:formz/formz.dart';

enum PhoneNumberValidationError { invalid, digitLess, digitExcess }

final class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure([super.value = '']) : super.pure();
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  static final _mobileNumberRegex = RegExp(
    r'^[6-9]{1}[0-9]{9}$',
  );

  @override
  PhoneNumberValidationError? validator(String? value) {
    print(value);
    print(_mobileNumberRegex.hasMatch(value ?? ''));
    if (value!.length < 10) {
      return PhoneNumberValidationError.digitLess;
    } else if (value.length > 10) {
      return PhoneNumberValidationError.digitExcess;
    }
    return _mobileNumberRegex.hasMatch(value ?? '')
        ? null
        : PhoneNumberValidationError.invalid;
  }
}

extension on PhoneNumberValidationError {
  String text() {
    switch (this) {
      case PhoneNumberValidationError.invalid:
        return 'Please ensure the phone number entered is valid';
      case PhoneNumberValidationError.digitLess:
        return 'The mobile number contains fewer than 10 digits.';
      case PhoneNumberValidationError.digitExcess:
        return 'The mobile number exceeds 10 digits.';
    }
  }
}
