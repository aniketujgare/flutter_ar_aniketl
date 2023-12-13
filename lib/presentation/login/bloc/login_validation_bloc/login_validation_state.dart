part of 'login_validation_bloc.dart';

@freezed
class LoginValidationState with _$LoginValidationState {
  const factory LoginValidationState({
    @Default(PhoneNumber.pure()) PhoneNumber phoneNumber,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = Initial;
}
