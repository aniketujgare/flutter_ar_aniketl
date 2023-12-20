// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'splash_animation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SplashAnimationEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Completed value) completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Completed value)? completed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashAnimationEventCopyWith<$Res> {
  factory $SplashAnimationEventCopyWith(SplashAnimationEvent value,
          $Res Function(SplashAnimationEvent) then) =
      _$SplashAnimationEventCopyWithImpl<$Res, SplashAnimationEvent>;
}

/// @nodoc
class _$SplashAnimationEventCopyWithImpl<$Res,
        $Val extends SplashAnimationEvent>
    implements $SplashAnimationEventCopyWith<$Res> {
  _$SplashAnimationEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$CompletedImplCopyWith<$Res> {
  factory _$$CompletedImplCopyWith(
          _$CompletedImpl value, $Res Function(_$CompletedImpl) then) =
      __$$CompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CompletedImplCopyWithImpl<$Res>
    extends _$SplashAnimationEventCopyWithImpl<$Res, _$CompletedImpl>
    implements _$$CompletedImplCopyWith<$Res> {
  __$$CompletedImplCopyWithImpl(
      _$CompletedImpl _value, $Res Function(_$CompletedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$CompletedImpl implements Completed {
  const _$CompletedImpl();

  @override
  String toString() {
    return 'SplashAnimationEvent.completed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() completed,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? completed,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Completed value) completed,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Completed value)? completed,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Completed value)? completed,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class Completed implements SplashAnimationEvent {
  const factory Completed() = _$CompletedImpl;
}

/// @nodoc
mixin _$SplashAnimationState {
  SplashStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SplashAnimationStateCopyWith<SplashAnimationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SplashAnimationStateCopyWith<$Res> {
  factory $SplashAnimationStateCopyWith(SplashAnimationState value,
          $Res Function(SplashAnimationState) then) =
      _$SplashAnimationStateCopyWithImpl<$Res, SplashAnimationState>;
  @useResult
  $Res call({SplashStatus status});
}

/// @nodoc
class _$SplashAnimationStateCopyWithImpl<$Res,
        $Val extends SplashAnimationState>
    implements $SplashAnimationStateCopyWith<$Res> {
  _$SplashAnimationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplashStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $SplashAnimationStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({SplashStatus status});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SplashAnimationStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as SplashStatus,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl({this.status = SplashStatus.initial});

  @override
  @JsonKey()
  final SplashStatus status;

  @override
  String toString() {
    return 'SplashAnimationState(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements SplashAnimationState {
  const factory Initial({final SplashStatus status}) = _$InitialImpl;

  @override
  SplashStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
