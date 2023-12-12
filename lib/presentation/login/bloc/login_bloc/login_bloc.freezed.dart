// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res, LoginEvent>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res, $Val extends LoginEvent>
    implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RequestOtpImplCopyWith<$Res> {
  factory _$$RequestOtpImplCopyWith(
          _$RequestOtpImpl value, $Res Function(_$RequestOtpImpl) then) =
      __$$RequestOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String verificationId, int? resendToken});
}

/// @nodoc
class __$$RequestOtpImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$RequestOtpImpl>
    implements _$$RequestOtpImplCopyWith<$Res> {
  __$$RequestOtpImplCopyWithImpl(
      _$RequestOtpImpl _value, $Res Function(_$RequestOtpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationId = null,
    Object? resendToken = freezed,
  }) {
    return _then(_$RequestOtpImpl(
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$RequestOtpImpl implements RequestOtp {
  const _$RequestOtpImpl({required this.verificationId, this.resendToken});

  @override
  final String verificationId;
  @override
  final int? resendToken;

  @override
  String toString() {
    return 'LoginEvent.requestOtp(verificationId: $verificationId, resendToken: $resendToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestOtpImpl &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendToken, resendToken) ||
                other.resendToken == resendToken));
  }

  @override
  int get hashCode => Object.hash(runtimeType, verificationId, resendToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestOtpImplCopyWith<_$RequestOtpImpl> get copyWith =>
      __$$RequestOtpImplCopyWithImpl<_$RequestOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return requestOtp(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return requestOtp?.call(verificationId, resendToken);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (requestOtp != null) {
      return requestOtp(verificationId, resendToken);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return requestOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return requestOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (requestOtp != null) {
      return requestOtp(this);
    }
    return orElse();
  }
}

abstract class RequestOtp implements LoginEvent {
  const factory RequestOtp(
      {required final String verificationId,
      final int? resendToken}) = _$RequestOtpImpl;

  String get verificationId;
  int? get resendToken;
  @JsonKey(ignore: true)
  _$$RequestOtpImplCopyWith<_$RequestOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$VerifyOtpImplCopyWith<$Res> {
  factory _$$VerifyOtpImplCopyWith(
          _$VerifyOtpImpl value, $Res Function(_$VerifyOtpImpl) then) =
      __$$VerifyOtpImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String verificationId, int? resendToken, String smsCode});
}

/// @nodoc
class __$$VerifyOtpImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$VerifyOtpImpl>
    implements _$$VerifyOtpImplCopyWith<$Res> {
  __$$VerifyOtpImplCopyWithImpl(
      _$VerifyOtpImpl _value, $Res Function(_$VerifyOtpImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? verificationId = null,
    Object? resendToken = freezed,
    Object? smsCode = null,
  }) {
    return _then(_$VerifyOtpImpl(
      verificationId: null == verificationId
          ? _value.verificationId
          : verificationId // ignore: cast_nullable_to_non_nullable
              as String,
      resendToken: freezed == resendToken
          ? _value.resendToken
          : resendToken // ignore: cast_nullable_to_non_nullable
              as int?,
      smsCode: null == smsCode
          ? _value.smsCode
          : smsCode // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$VerifyOtpImpl implements VerifyOtp {
  const _$VerifyOtpImpl(
      {required this.verificationId, this.resendToken, required this.smsCode});

  @override
  final String verificationId;
  @override
  final int? resendToken;
  @override
  final String smsCode;

  @override
  String toString() {
    return 'LoginEvent.verifyOtp(verificationId: $verificationId, resendToken: $resendToken, smsCode: $smsCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOtpImpl &&
            (identical(other.verificationId, verificationId) ||
                other.verificationId == verificationId) &&
            (identical(other.resendToken, resendToken) ||
                other.resendToken == resendToken) &&
            (identical(other.smsCode, smsCode) || other.smsCode == smsCode));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, verificationId, resendToken, smsCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      __$$VerifyOtpImplCopyWithImpl<_$VerifyOtpImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return verifyOtp(verificationId, resendToken, smsCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return verifyOtp?.call(verificationId, resendToken, smsCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(verificationId, resendToken, smsCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return verifyOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return verifyOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (verifyOtp != null) {
      return verifyOtp(this);
    }
    return orElse();
  }
}

abstract class VerifyOtp implements LoginEvent {
  const factory VerifyOtp(
      {required final String verificationId,
      final int? resendToken,
      required final String smsCode}) = _$VerifyOtpImpl;

  String get verificationId;
  int? get resendToken;
  String get smsCode;
  @JsonKey(ignore: true)
  _$$VerifyOtpImplCopyWith<_$VerifyOtpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UpdateStatusImplCopyWith<$Res> {
  factory _$$UpdateStatusImplCopyWith(
          _$UpdateStatusImpl value, $Res Function(_$UpdateStatusImpl) then) =
      __$$UpdateStatusImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginStatus status});
}

/// @nodoc
class __$$UpdateStatusImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$UpdateStatusImpl>
    implements _$$UpdateStatusImplCopyWith<$Res> {
  __$$UpdateStatusImplCopyWithImpl(
      _$UpdateStatusImpl _value, $Res Function(_$UpdateStatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$UpdateStatusImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
    ));
  }
}

/// @nodoc

class _$UpdateStatusImpl implements UpdateStatus {
  const _$UpdateStatusImpl({this.status = LoginStatus.phoneNo1});

  @override
  @JsonKey()
  final LoginStatus status;

  @override
  String toString() {
    return 'LoginEvent.updateStatus(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UpdateStatusImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UpdateStatusImplCopyWith<_$UpdateStatusImpl> get copyWith =>
      __$$UpdateStatusImplCopyWithImpl<_$UpdateStatusImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return updateStatus(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return updateStatus?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (updateStatus != null) {
      return updateStatus(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return updateStatus(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return updateStatus?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (updateStatus != null) {
      return updateStatus(this);
    }
    return orElse();
  }
}

abstract class UpdateStatus implements LoginEvent {
  const factory UpdateStatus({final LoginStatus status}) = _$UpdateStatusImpl;

  LoginStatus get status;
  @JsonKey(ignore: true)
  _$$UpdateStatusImplCopyWith<_$UpdateStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CheckMobileNoExistsImplCopyWith<$Res> {
  factory _$$CheckMobileNoExistsImplCopyWith(_$CheckMobileNoExistsImpl value,
          $Res Function(_$CheckMobileNoExistsImpl) then) =
      __$$CheckMobileNoExistsImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mobileNumber});
}

/// @nodoc
class __$$CheckMobileNoExistsImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$CheckMobileNoExistsImpl>
    implements _$$CheckMobileNoExistsImplCopyWith<$Res> {
  __$$CheckMobileNoExistsImplCopyWithImpl(_$CheckMobileNoExistsImpl _value,
      $Res Function(_$CheckMobileNoExistsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobileNumber = null,
  }) {
    return _then(_$CheckMobileNoExistsImpl(
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$CheckMobileNoExistsImpl implements CheckMobileNoExists {
  const _$CheckMobileNoExistsImpl({this.mobileNumber = ""});

  @override
  @JsonKey()
  final String mobileNumber;

  @override
  String toString() {
    return 'LoginEvent.checkMobileNoExists(mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CheckMobileNoExistsImpl &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mobileNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CheckMobileNoExistsImplCopyWith<_$CheckMobileNoExistsImpl> get copyWith =>
      __$$CheckMobileNoExistsImplCopyWithImpl<_$CheckMobileNoExistsImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return checkMobileNoExists(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return checkMobileNoExists?.call(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (checkMobileNoExists != null) {
      return checkMobileNoExists(mobileNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return checkMobileNoExists(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return checkMobileNoExists?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (checkMobileNoExists != null) {
      return checkMobileNoExists(this);
    }
    return orElse();
  }
}

abstract class CheckMobileNoExists implements LoginEvent {
  const factory CheckMobileNoExists({final String mobileNumber}) =
      _$CheckMobileNoExistsImpl;

  String get mobileNumber;
  @JsonKey(ignore: true)
  _$$CheckMobileNoExistsImplCopyWith<_$CheckMobileNoExistsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberAuthImplCopyWith<$Res> {
  factory _$$PhoneNumberAuthImplCopyWith(_$PhoneNumberAuthImpl value,
          $Res Function(_$PhoneNumberAuthImpl) then) =
      __$$PhoneNumberAuthImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String mobileNumber});
}

/// @nodoc
class __$$PhoneNumberAuthImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$PhoneNumberAuthImpl>
    implements _$$PhoneNumberAuthImplCopyWith<$Res> {
  __$$PhoneNumberAuthImplCopyWithImpl(
      _$PhoneNumberAuthImpl _value, $Res Function(_$PhoneNumberAuthImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mobileNumber = null,
  }) {
    return _then(_$PhoneNumberAuthImpl(
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberAuthImpl implements PhoneNumberAuth {
  const _$PhoneNumberAuthImpl({this.mobileNumber = ""});

  @override
  @JsonKey()
  final String mobileNumber;

  @override
  String toString() {
    return 'LoginEvent.phoneNumberAuth(mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberAuthImpl &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, mobileNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberAuthImplCopyWith<_$PhoneNumberAuthImpl> get copyWith =>
      __$$PhoneNumberAuthImplCopyWithImpl<_$PhoneNumberAuthImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return phoneNumberAuth(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return phoneNumberAuth?.call(mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (phoneNumberAuth != null) {
      return phoneNumberAuth(mobileNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return phoneNumberAuth(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return phoneNumberAuth?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (phoneNumberAuth != null) {
      return phoneNumberAuth(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberAuth implements LoginEvent {
  const factory PhoneNumberAuth({final String mobileNumber}) =
      _$PhoneNumberAuthImpl;

  String get mobileNumber;
  @JsonKey(ignore: true)
  _$$PhoneNumberAuthImplCopyWith<_$PhoneNumberAuthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginErrorImplCopyWith<$Res> {
  factory _$$LoginErrorImplCopyWith(
          _$LoginErrorImpl value, $Res Function(_$LoginErrorImpl) then) =
      __$$LoginErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String errorMessage});
}

/// @nodoc
class __$$LoginErrorImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$LoginErrorImpl>
    implements _$$LoginErrorImplCopyWith<$Res> {
  __$$LoginErrorImplCopyWithImpl(
      _$LoginErrorImpl _value, $Res Function(_$LoginErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = null,
  }) {
    return _then(_$LoginErrorImpl(
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoginErrorImpl implements LoginError {
  const _$LoginErrorImpl({this.errorMessage = ''});

  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'LoginEvent.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginErrorImpl &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginErrorImplCopyWith<_$LoginErrorImpl> get copyWith =>
      __$$LoginErrorImplCopyWithImpl<_$LoginErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LoginError implements LoginEvent {
  const factory LoginError({final String errorMessage}) = _$LoginErrorImpl;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$$LoginErrorImplCopyWith<_$LoginErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GuestLoginImplCopyWith<$Res> {
  factory _$$GuestLoginImplCopyWith(
          _$GuestLoginImpl value, $Res Function(_$GuestLoginImpl) then) =
      __$$GuestLoginImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String parentsName, String mobileNumber});
}

/// @nodoc
class __$$GuestLoginImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$GuestLoginImpl>
    implements _$$GuestLoginImplCopyWith<$Res> {
  __$$GuestLoginImplCopyWithImpl(
      _$GuestLoginImpl _value, $Res Function(_$GuestLoginImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? parentsName = null,
    Object? mobileNumber = null,
  }) {
    return _then(_$GuestLoginImpl(
      parentsName: null == parentsName
          ? _value.parentsName
          : parentsName // ignore: cast_nullable_to_non_nullable
              as String,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GuestLoginImpl implements GuestLogin {
  const _$GuestLoginImpl({this.parentsName = '', this.mobileNumber = ''});

  @override
  @JsonKey()
  final String parentsName;
  @override
  @JsonKey()
  final String mobileNumber;

  @override
  String toString() {
    return 'LoginEvent.guestLogin(parentsName: $parentsName, mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuestLoginImpl &&
            (identical(other.parentsName, parentsName) ||
                other.parentsName == parentsName) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, parentsName, mobileNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GuestLoginImplCopyWith<_$GuestLoginImpl> get copyWith =>
      __$$GuestLoginImplCopyWithImpl<_$GuestLoginImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return guestLogin(parentsName, mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return guestLogin?.call(parentsName, mobileNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (guestLogin != null) {
      return guestLogin(parentsName, mobileNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return guestLogin(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return guestLogin?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (guestLogin != null) {
      return guestLogin(this);
    }
    return orElse();
  }
}

abstract class GuestLogin implements LoginEvent {
  const factory GuestLogin(
      {final String parentsName, final String mobileNumber}) = _$GuestLoginImpl;

  String get parentsName;
  String get mobileNumber;
  @JsonKey(ignore: true)
  _$$GuestLoginImplCopyWith<_$GuestLoginImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ResendOTPImplCopyWith<$Res> {
  factory _$$ResendOTPImplCopyWith(
          _$ResendOTPImpl value, $Res Function(_$ResendOTPImpl) then) =
      __$$ResendOTPImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ResendOTPImplCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res, _$ResendOTPImpl>
    implements _$$ResendOTPImplCopyWith<$Res> {
  __$$ResendOTPImplCopyWithImpl(
      _$ResendOTPImpl _value, $Res Function(_$ResendOTPImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$ResendOTPImpl implements ResendOTP {
  const _$ResendOTPImpl();

  @override
  String toString() {
    return 'LoginEvent.resendOtp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ResendOTPImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String verificationId, int? resendToken)
        requestOtp,
    required TResult Function(
            String verificationId, int? resendToken, String smsCode)
        verifyOtp,
    required TResult Function(LoginStatus status) updateStatus,
    required TResult Function(String mobileNumber) checkMobileNoExists,
    required TResult Function(String mobileNumber) phoneNumberAuth,
    required TResult Function(String errorMessage) error,
    required TResult Function(String parentsName, String mobileNumber)
        guestLogin,
    required TResult Function() resendOtp,
  }) {
    return resendOtp();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String verificationId, int? resendToken)? requestOtp,
    TResult? Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult? Function(LoginStatus status)? updateStatus,
    TResult? Function(String mobileNumber)? checkMobileNoExists,
    TResult? Function(String mobileNumber)? phoneNumberAuth,
    TResult? Function(String errorMessage)? error,
    TResult? Function(String parentsName, String mobileNumber)? guestLogin,
    TResult? Function()? resendOtp,
  }) {
    return resendOtp?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String verificationId, int? resendToken)? requestOtp,
    TResult Function(String verificationId, int? resendToken, String smsCode)?
        verifyOtp,
    TResult Function(LoginStatus status)? updateStatus,
    TResult Function(String mobileNumber)? checkMobileNoExists,
    TResult Function(String mobileNumber)? phoneNumberAuth,
    TResult Function(String errorMessage)? error,
    TResult Function(String parentsName, String mobileNumber)? guestLogin,
    TResult Function()? resendOtp,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestOtp value) requestOtp,
    required TResult Function(VerifyOtp value) verifyOtp,
    required TResult Function(UpdateStatus value) updateStatus,
    required TResult Function(CheckMobileNoExists value) checkMobileNoExists,
    required TResult Function(PhoneNumberAuth value) phoneNumberAuth,
    required TResult Function(LoginError value) error,
    required TResult Function(GuestLogin value) guestLogin,
    required TResult Function(ResendOTP value) resendOtp,
  }) {
    return resendOtp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestOtp value)? requestOtp,
    TResult? Function(VerifyOtp value)? verifyOtp,
    TResult? Function(UpdateStatus value)? updateStatus,
    TResult? Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult? Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult? Function(LoginError value)? error,
    TResult? Function(GuestLogin value)? guestLogin,
    TResult? Function(ResendOTP value)? resendOtp,
  }) {
    return resendOtp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestOtp value)? requestOtp,
    TResult Function(VerifyOtp value)? verifyOtp,
    TResult Function(UpdateStatus value)? updateStatus,
    TResult Function(CheckMobileNoExists value)? checkMobileNoExists,
    TResult Function(PhoneNumberAuth value)? phoneNumberAuth,
    TResult Function(LoginError value)? error,
    TResult Function(GuestLogin value)? guestLogin,
    TResult Function(ResendOTP value)? resendOtp,
    required TResult orElse(),
  }) {
    if (resendOtp != null) {
      return resendOtp(this);
    }
    return orElse();
  }
}

abstract class ResendOTP implements LoginEvent {
  const factory ResendOTP() = _$ResendOTPImpl;
}

/// @nodoc
mixin _$LoginState {
  LoginStatus get status => throw _privateConstructorUsedError;
  String get mobileNumber => throw _privateConstructorUsedError;
  String get parentName => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  bool get isGuest => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res, LoginState>;
  @useResult
  $Res call(
      {LoginStatus status,
      String mobileNumber,
      String parentName,
      String errorMessage,
      bool isGuest});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? mobileNumber = null,
    Object? parentName = null,
    Object? errorMessage = null,
    Object? isGuest = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentName: null == parentName
          ? _value.parentName
          : parentName // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isGuest: null == isGuest
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {LoginStatus status,
      String mobileNumber,
      String parentName,
      String errorMessage,
      bool isGuest});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? mobileNumber = null,
    Object? parentName = null,
    Object? errorMessage = null,
    Object? isGuest = null,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LoginStatus,
      mobileNumber: null == mobileNumber
          ? _value.mobileNumber
          : mobileNumber // ignore: cast_nullable_to_non_nullable
              as String,
      parentName: null == parentName
          ? _value.parentName
          : parentName // ignore: cast_nullable_to_non_nullable
              as String,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
      isGuest: null == isGuest
          ? _value.isGuest
          : isGuest // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl(
      {this.status = LoginStatus.phoneNo1,
      this.mobileNumber = "",
      this.parentName = "",
      this.errorMessage = "",
      this.isGuest = false});

  @override
  @JsonKey()
  final LoginStatus status;
  @override
  @JsonKey()
  final String mobileNumber;
  @override
  @JsonKey()
  final String parentName;
  @override
  @JsonKey()
  final String errorMessage;
  @override
  @JsonKey()
  final bool isGuest;

  @override
  String toString() {
    return 'LoginState(status: $status, mobileNumber: $mobileNumber, parentName: $parentName, errorMessage: $errorMessage, isGuest: $isGuest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.mobileNumber, mobileNumber) ||
                other.mobileNumber == mobileNumber) &&
            (identical(other.parentName, parentName) ||
                other.parentName == parentName) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.isGuest, isGuest) || other.isGuest == isGuest));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, status, mobileNumber, parentName, errorMessage, isGuest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements LoginState {
  const factory Initial(
      {final LoginStatus status,
      final String mobileNumber,
      final String parentName,
      final String errorMessage,
      final bool isGuest}) = _$InitialImpl;

  @override
  LoginStatus get status;
  @override
  String get mobileNumber;
  @override
  String get parentName;
  @override
  String get errorMessage;
  @override
  bool get isGuest;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
