// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'guest_validation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GuestValidationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function(String guestName) guestNameChanged,
    required TResult Function() guestFormSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function(String guestName)? guestNameChanged,
    TResult? Function()? guestFormSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function(String guestName)? guestNameChanged,
    TResult Function()? guestFormSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(GuestNameChanged value) guestNameChanged,
    required TResult Function(GuestFormSubmitted value) guestFormSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(GuestNameChanged value)? guestNameChanged,
    TResult? Function(GuestFormSubmitted value)? guestFormSubmitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(GuestNameChanged value)? guestNameChanged,
    TResult Function(GuestFormSubmitted value)? guestFormSubmitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuestValidationEventCopyWith<$Res> {
  factory $GuestValidationEventCopyWith(GuestValidationEvent value,
          $Res Function(GuestValidationEvent) then) =
      _$GuestValidationEventCopyWithImpl<$Res, GuestValidationEvent>;
}

/// @nodoc
class _$GuestValidationEventCopyWithImpl<$Res,
        $Val extends GuestValidationEvent>
    implements $GuestValidationEventCopyWith<$Res> {
  _$GuestValidationEventCopyWithImpl(this._value, this._then);

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
    extends _$GuestValidationEventCopyWithImpl<$Res, _$PhoneNumberChangedImpl>
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
    return 'GuestValidationEvent.phoneNumberChanged(phoneNumber: $phoneNumber)';
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
    required TResult Function(String guestName) guestNameChanged,
    required TResult Function() guestFormSubmitted,
  }) {
    return phoneNumberChanged(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function(String guestName)? guestNameChanged,
    TResult? Function()? guestFormSubmitted,
  }) {
    return phoneNumberChanged?.call(phoneNumber);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function(String guestName)? guestNameChanged,
    TResult Function()? guestFormSubmitted,
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
    required TResult Function(GuestNameChanged value) guestNameChanged,
    required TResult Function(GuestFormSubmitted value) guestFormSubmitted,
  }) {
    return phoneNumberChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(GuestNameChanged value)? guestNameChanged,
    TResult? Function(GuestFormSubmitted value)? guestFormSubmitted,
  }) {
    return phoneNumberChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(GuestNameChanged value)? guestNameChanged,
    TResult Function(GuestFormSubmitted value)? guestFormSubmitted,
    required TResult orElse(),
  }) {
    if (phoneNumberChanged != null) {
      return phoneNumberChanged(this);
    }
    return orElse();
  }
}

abstract class PhoneNumberChanged implements GuestValidationEvent {
  const factory PhoneNumberChanged({required final String phoneNumber}) =
      _$PhoneNumberChangedImpl;

  String get phoneNumber;
  @JsonKey(ignore: true)
  _$$PhoneNumberChangedImplCopyWith<_$PhoneNumberChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GuestNameChangedImplCopyWith<$Res> {
  factory _$$GuestNameChangedImplCopyWith(_$GuestNameChangedImpl value,
          $Res Function(_$GuestNameChangedImpl) then) =
      __$$GuestNameChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String guestName});
}

/// @nodoc
class __$$GuestNameChangedImplCopyWithImpl<$Res>
    extends _$GuestValidationEventCopyWithImpl<$Res, _$GuestNameChangedImpl>
    implements _$$GuestNameChangedImplCopyWith<$Res> {
  __$$GuestNameChangedImplCopyWithImpl(_$GuestNameChangedImpl _value,
      $Res Function(_$GuestNameChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guestName = null,
  }) {
    return _then(_$GuestNameChangedImpl(
      guestName: null == guestName
          ? _value.guestName
          : guestName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$GuestNameChangedImpl implements GuestNameChanged {
  const _$GuestNameChangedImpl({required this.guestName});

  @override
  final String guestName;

  @override
  String toString() {
    return 'GuestValidationEvent.guestNameChanged(guestName: $guestName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GuestNameChangedImpl &&
            (identical(other.guestName, guestName) ||
                other.guestName == guestName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, guestName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GuestNameChangedImplCopyWith<_$GuestNameChangedImpl> get copyWith =>
      __$$GuestNameChangedImplCopyWithImpl<_$GuestNameChangedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function(String guestName) guestNameChanged,
    required TResult Function() guestFormSubmitted,
  }) {
    return guestNameChanged(guestName);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function(String guestName)? guestNameChanged,
    TResult? Function()? guestFormSubmitted,
  }) {
    return guestNameChanged?.call(guestName);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function(String guestName)? guestNameChanged,
    TResult Function()? guestFormSubmitted,
    required TResult orElse(),
  }) {
    if (guestNameChanged != null) {
      return guestNameChanged(guestName);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(GuestNameChanged value) guestNameChanged,
    required TResult Function(GuestFormSubmitted value) guestFormSubmitted,
  }) {
    return guestNameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(GuestNameChanged value)? guestNameChanged,
    TResult? Function(GuestFormSubmitted value)? guestFormSubmitted,
  }) {
    return guestNameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(GuestNameChanged value)? guestNameChanged,
    TResult Function(GuestFormSubmitted value)? guestFormSubmitted,
    required TResult orElse(),
  }) {
    if (guestNameChanged != null) {
      return guestNameChanged(this);
    }
    return orElse();
  }
}

abstract class GuestNameChanged implements GuestValidationEvent {
  const factory GuestNameChanged({required final String guestName}) =
      _$GuestNameChangedImpl;

  String get guestName;
  @JsonKey(ignore: true)
  _$$GuestNameChangedImplCopyWith<_$GuestNameChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$GuestFormSubmittedImplCopyWith<$Res> {
  factory _$$GuestFormSubmittedImplCopyWith(_$GuestFormSubmittedImpl value,
          $Res Function(_$GuestFormSubmittedImpl) then) =
      __$$GuestFormSubmittedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$GuestFormSubmittedImplCopyWithImpl<$Res>
    extends _$GuestValidationEventCopyWithImpl<$Res, _$GuestFormSubmittedImpl>
    implements _$$GuestFormSubmittedImplCopyWith<$Res> {
  __$$GuestFormSubmittedImplCopyWithImpl(_$GuestFormSubmittedImpl _value,
      $Res Function(_$GuestFormSubmittedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$GuestFormSubmittedImpl implements GuestFormSubmitted {
  const _$GuestFormSubmittedImpl();

  @override
  String toString() {
    return 'GuestValidationEvent.guestFormSubmitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$GuestFormSubmittedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phoneNumber) phoneNumberChanged,
    required TResult Function(String guestName) guestNameChanged,
    required TResult Function() guestFormSubmitted,
  }) {
    return guestFormSubmitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String phoneNumber)? phoneNumberChanged,
    TResult? Function(String guestName)? guestNameChanged,
    TResult? Function()? guestFormSubmitted,
  }) {
    return guestFormSubmitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phoneNumber)? phoneNumberChanged,
    TResult Function(String guestName)? guestNameChanged,
    TResult Function()? guestFormSubmitted,
    required TResult orElse(),
  }) {
    if (guestFormSubmitted != null) {
      return guestFormSubmitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PhoneNumberChanged value) phoneNumberChanged,
    required TResult Function(GuestNameChanged value) guestNameChanged,
    required TResult Function(GuestFormSubmitted value) guestFormSubmitted,
  }) {
    return guestFormSubmitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult? Function(GuestNameChanged value)? guestNameChanged,
    TResult? Function(GuestFormSubmitted value)? guestFormSubmitted,
  }) {
    return guestFormSubmitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PhoneNumberChanged value)? phoneNumberChanged,
    TResult Function(GuestNameChanged value)? guestNameChanged,
    TResult Function(GuestFormSubmitted value)? guestFormSubmitted,
    required TResult orElse(),
  }) {
    if (guestFormSubmitted != null) {
      return guestFormSubmitted(this);
    }
    return orElse();
  }
}

abstract class GuestFormSubmitted implements GuestValidationEvent {
  const factory GuestFormSubmitted() = _$GuestFormSubmittedImpl;
}

/// @nodoc
mixin _$GuestValidationState {
  GuestName get guestName => throw _privateConstructorUsedError;
  PhoneNumber get phoneNumber => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GuestValidationStateCopyWith<GuestValidationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GuestValidationStateCopyWith<$Res> {
  factory $GuestValidationStateCopyWith(GuestValidationState value,
          $Res Function(GuestValidationState) then) =
      _$GuestValidationStateCopyWithImpl<$Res, GuestValidationState>;
  @useResult
  $Res call(
      {GuestName guestName,
      PhoneNumber phoneNumber,
      bool isValid,
      FormzSubmissionStatus status});
}

/// @nodoc
class _$GuestValidationStateCopyWithImpl<$Res,
        $Val extends GuestValidationState>
    implements $GuestValidationStateCopyWith<$Res> {
  _$GuestValidationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guestName = null,
    Object? phoneNumber = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      guestName: null == guestName
          ? _value.guestName
          : guestName // ignore: cast_nullable_to_non_nullable
              as GuestName,
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
    implements $GuestValidationStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {GuestName guestName,
      PhoneNumber phoneNumber,
      bool isValid,
      FormzSubmissionStatus status});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$GuestValidationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guestName = null,
    Object? phoneNumber = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_$InitialImpl(
      guestName: null == guestName
          ? _value.guestName
          : guestName // ignore: cast_nullable_to_non_nullable
              as GuestName,
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
      {this.guestName = const GuestName.pure(),
      this.phoneNumber = const PhoneNumber.pure(),
      this.isValid = false,
      this.status = FormzSubmissionStatus.initial});

  @override
  @JsonKey()
  final GuestName guestName;
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
    return 'GuestValidationState(guestName: $guestName, phoneNumber: $phoneNumber, isValid: $isValid, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.guestName, guestName) ||
                other.guestName == guestName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, guestName, phoneNumber, isValid, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements GuestValidationState {
  const factory Initial(
      {final GuestName guestName,
      final PhoneNumber phoneNumber,
      final bool isValid,
      final FormzSubmissionStatus status}) = _$InitialImpl;

  @override
  GuestName get guestName;
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
