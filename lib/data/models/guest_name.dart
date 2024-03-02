import 'package:flutter/foundation.dart' show debugPrint;
import 'package:formz/formz.dart';

enum GuestNameValidationError { invalid }

final class GuestName extends FormzInput<String, GuestNameValidationError> {
  const GuestName.pure([super.value = '']) : super.pure();
  const GuestName.dirty([super.value = '']) : super.dirty();

  static final _guestNameRegex = RegExp(
    r'^[a-zA-Z ]+$',
  );

  @override
  GuestNameValidationError? validator(String? value) {
    debugPrint('$value ->${_guestNameRegex.hasMatch(value!)}');
    // print(_guestNameRegex.hasMatch(value ?? ''));
    // return null;
    return _guestNameRegex.hasMatch(value ?? '')
        ? null
        : GuestNameValidationError.invalid;
  }
}

extension ErrorString on GuestNameValidationError {
  String text() {
    return 'Please ensure name only contains alphabets';
  }
}
