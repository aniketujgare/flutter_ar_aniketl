// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_validation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LoginValidationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() phoneNumberSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? phoneNumberSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? phoneNumberSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(PhoneNumberSubmitted value) phoneNumberSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginValidationEventCopyWith<$Res> {
  factory $LoginValidationEventCopyWith(LoginValidationEvent value,
          $Res Function(LoginValidationEvent) then) =
      _$LoginValidationEventCopyWithImpl<$Res, LoginValidationEvent>;
}

/// @nodoc
class _$LoginValidationEventCopyWithImpl<$Res,
        $Val extends LoginValidationEvent>
    implements $LoginValidationEventCopyWith<$Res> {
  _$LoginValidationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PhoneNumberChangedImplCopyWith<$Res> {
  factory _$$PhoneNumberChangedImplCopyWith(_$PhoneNumberChangedImpl value,
          $Res Function(_$PhoneNumberChangedImpl) then) =
      __$$PhoneNumberChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String phoneNumber});
}

/// @nodoc
class __$$PhoneNumberChangedImplCopyWithImpl<$Res>
    extends _$LoginValidationEventCopyWithImpl<$Res, _$PhoneNumberChangedImpl>
    implements _$$PhoneNumberChangedImplCopyWith<$Res> {
  __$$PhoneNumberChangedImplCopyWithImpl(_$PhoneNumberChangedImpl _value,
      $Res Function(_$PhoneNumberChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
  }) {
    return _then(_$PhoneNumberChangedImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhoneNumberChangedImpl implements PhoneNumberChanged {
  const _$PhoneNumberChangedImpl({required this.phoneNumber});

  @override
  final String phoneNumber;

  @override
  String toString() {
    return 'LoginValidationEvent.phoneNumberChanged(phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberChangedImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      __$$PhoneNumberChangedImplCopyWithImpl<_$PhoneNumberChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() phoneNumberSubmitted,
  }) {
    return phoneNumberChanged(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? phoneNumberSubmitted,
  }) {
    return phoneNumberChanged?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? phoneNumberSubmitted,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(phoneNumber);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(PhoneNumberSubmitted value) phoneNumberSubmitted,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberChanged implements LoginValidationEvent {
  const factory PhoneNumberChanged({required final String phoneNumber}) =
      _$PhoneNumberChangedImpl;

  String get phoneNumber;
  @JsonKey(ignore: true)
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PhoneNumberSubmittedImplCopyWith<$Res> {
  factory _$$PhoneNumberSubmittedImplCopyWith(_$PhoneNumberSubmittedImpl value,
          $Res Function(_$PhoneNumberSubmittedImpl) then) =
      __$$PhoneNumberSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PhoneNumberSubmittedImplCopyWithImpl<$Res>
    extends _$LoginValidationEventCopyWithImpl<$Res, _$PhoneNumberSubmittedImpl>
    implements _$$PhoneNumberSubmittedImplCopyWith<$Res> {
  __$$PhoneNumberSubmittedImplCopyWithImpl(_$PhoneNumberSubmittedImpl _value,
      $Res Function(_$PhoneNumberSubmittedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PhoneNumberSubmittedImpl implements PhoneNumberSubmitted {
  const _$PhoneNumberSubmittedImpl();

  @override
  String toString() {
    return 'LoginValidationEvent.phoneNumberSubmitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhoneNumberSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function() phoneNumberSubmitted,
  }) {
    return phoneNumberSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function()? phoneNumberSubmitted,
  }) {
    return phoneNumberSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function()? phoneNumberSubmitted,
    required TResult orElse(),
  }) {
    if (phoneNumberSubmitted != null) {
      return phoneNumberSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(PhoneNumberSubmitted value) phoneNumberSubmitted,
  }) {
    return phoneNumberSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
  }) {
    return phoneNumberSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(PhoneNumberSubmitted value)? phoneNumberSubmitted,
    required TResult orElse(),
  }) {
    if (phoneNumberSubmitted != null) {
      return phoneNumberSubmitted(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberSubmitted implements LoginValidationEvent {
  const factory PhoneNumberSubmitted() = _$PhoneNumberSubmittedImpl;
}

/// @nodoc
mixin _$LoginValidationState {
  PhoneNumber get phoneNumber => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginValidationStateCopyWith<LoginValidationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginValidationStateCopyWith<$Res> {
  factory $LoginValidationStateCopyWith(LoginValidationState value,
          $Res Function(LoginValidationState) then) =
      _$LoginValidationStateCopyWithImpl<$Res, LoginValidationState>;
  @useResult
  $Res call(
      {PhoneNumber phoneNumber, bool isValid, FormzSubmissionStatus status});
}

/// @nodoc
class _$LoginValidationStateCopyWithImpl<$Res,
        $Val extends LoginValidationState>
    implements $LoginValidationStateCopyWith<$Res> {
  _$LoginValidationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $LoginValidationStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PhoneNumber phoneNumber, bool isValid, FormzSubmissionStatus status});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$LoginValidationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? phoneNumber = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_$InitialImpl(
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as PhoneNumber,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl(
      {this.phoneNumber = const PhoneNumber.pure(),
      this.isValid = false,
      this.status = FormzSubmissionStatus.initial});

  @override
  @JsonKey()
  final PhoneNumber phoneNumber;
  @override
  @JsonKey()
  final bool isValid;
  @override
  @JsonKey()
  final FormzSubmissionStatus status;

  @override
  String toString() {
    return 'LoginValidationState(phoneNumber: $phoneNumber, isValid: $isValid, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, phoneNumber, isValid, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements LoginValidationState {
  const factory Initial(
      {final PhoneNumber phoneNumber,
      final bool isValid,
      final FormzSubmissionStatus status}) = _$InitialImpl;

  @override
  PhoneNumber get phoneNumber;
  @override
  bool get isValid;
  @override
  FormzSubmissionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
