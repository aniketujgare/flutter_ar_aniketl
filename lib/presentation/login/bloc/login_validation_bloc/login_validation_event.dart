part of 'login_validation_bloc.dart';

@freezed
class LoginValidationEvent with _$LoginValidationEvent {
  const factory LoginValidationEvent.phoneNumberChanged(
      {required String phoneNumber}) = PhoneNumberChanged;

  const factory LoginValidationEvent.phoneNumberSubmitted() =
      PhoneNumberSubmitted;
}
