part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.requestOtp(
      {required String verificationId, int? resendToken}) = RequestOtp;
  const factory LoginEvent.verifyOtp(
      {required String verificationId,
      int? resendToken,
      required String smsCode}) = VerifyOtp;
  const factory LoginEvent.updateStatus({
    @Default(LoginStatus.phoneNo1) LoginStatus status,
  }) = UpdateStatus;
  const factory LoginEvent.checkMobileNoExists(
      {@Default("") String mobileNumber}) = CheckMobileNoExists;
  const factory LoginEvent.phoneNumberAuth({@Default("") String mobileNumber}) =
      PhoneNumberAuth;
  const factory LoginEvent.error({@Default('') String errorMessage}) =
      LoginError;
  const factory LoginEvent.guestLogin(
      {@Default('') String parentsName,
      @Default('') String mobileNumber}) = GuestLogin;
  const factory LoginEvent.resendOtp() = ResendOTP;
}
