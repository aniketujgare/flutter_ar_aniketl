// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models_new_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ModelsNewState {
  ModelsStatus get status => throw _privateConstructorUsedError;
  List<ArModel> get arModels => throw _privateConstructorUsedError;
  String get errorMsg => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ModelsNewStateCopyWith<ModelsNewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelsNewStateCopyWith<$Res> {
  factory $ModelsNewStateCopyWith(
          ModelsNewState value, $Res Function(ModelsNewState) then) =
      _$ModelsNewStateCopyWithImpl<$Res, ModelsNewState>;
  @useResult
  $Res call({ModelsStatus status, List<ArModel> arModels, String errorMsg});
}

/// @nodoc
class _$ModelsNewStateCopyWithImpl<$Res, $Val extends ModelsNewState>
    implements $ModelsNewStateCopyWith<$Res> {
  _$ModelsNewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? arModels = null,
    Object? errorMsg = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ModelsStatus,
      arModels: null == arModels
          ? _value.arModels
          : arModels // ignore: cast_nullable_to_non_nullable
              as List<ArModel>,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $ModelsNewStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ModelsStatus status, List<ArModel> arModels, String errorMsg});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$ModelsNewStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? arModels = null,
    Object? errorMsg = null,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ModelsStatus,
      arModels: null == arModels
          ? _value._arModels
          : arModels // ignore: cast_nullable_to_non_nullable
              as List<ArModel>,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$InitialImpl implements Initial {
  const _$InitialImpl(
      {this.status = ModelsStatus.initial,
      final List<ArModel> arModels = const [],
      this.errorMsg = 'Failed to load categories'})
      : _arModels = arModels;

  @override
  @JsonKey()
  final ModelsStatus status;
  final List<ArModel> _arModels;
  @override
  @JsonKey()
  List<ArModel> get arModels {
    if (_arModels is EqualUnmodifiableListView) return _arModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arModels);
  }

  @override
  @JsonKey()
  final String errorMsg;

  @override
  String toString() {
    return 'ModelsNewState(status: $status, arModels: $arModels, errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._arModels, _arModels) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_arModels), errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements ModelsNewState {
  const factory Initial(
      {final ModelsStatus status,
      final List<ArModel> arModels,
      final String errorMsg}) = _$InitialImpl;

  @override
  ModelsStatus get status;
  @override
  List<ArModel> get arModels;
  @override
  String get errorMsg;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
