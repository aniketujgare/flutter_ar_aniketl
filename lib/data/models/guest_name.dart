import 'package:formz/formz.dart';

enum GuestNameValidationError { invalid }

final class GuestName extends FormzInput<String, GuestNameValidationError> {
  const GuestName.pure([super.value = '']) : super.pure();
  const GuestName.dirty([super.value = '']) : super.dirty();

  static final _guestNameRegex = RegExp(
    r'\D',
  );

  @override
  GuestNameValidationError? validator(String? value) {
    print(value);
    print(_guestNameRegex.hasMatch(value ?? ''));
    // return null;
    return _guestNameRegex.hasMatch(value ?? '')
        ? null
        : GuestNameValidationError.invalid;
  }
}
