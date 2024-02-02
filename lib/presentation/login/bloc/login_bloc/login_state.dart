part of 'login_bloc.dart';

enum LoginStatus {
  phoneNo1,
  otp2,
  parents3,
  guest,
  loading,
  error,
  wrongOtp,
  success
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.phoneNo1) LoginStatus status,
    @Default("") String mobileNumber,
    @Default("") String parentName,
    @Default("") String errorMessage,
    @Default(false) bool isGuest,
  }) = Initial;
}
