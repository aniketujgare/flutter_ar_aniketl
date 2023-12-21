// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_new_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CategoryNewState {
  CategoryStatus get status => throw _privateConstructorUsedError;
  List<ArCategory> get arCategory => throw _privateConstructorUsedError;
  String get errorMsg => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryNewStateCopyWith<CategoryNewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryNewStateCopyWith<$Res> {
  factory $CategoryNewStateCopyWith(
          CategoryNewState value, $Res Function(CategoryNewState) then) =
      _$CategoryNewStateCopyWithImpl<$Res, CategoryNewState>;
  @useResult
  $Res call(
      {CategoryStatus status, List<ArCategory> arCategory, String errorMsg});
}

/// @nodoc
class _$CategoryNewStateCopyWithImpl<$Res, $Val extends CategoryNewState>
    implements $CategoryNewStateCopyWith<$Res> {
  _$CategoryNewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? arCategory = null,
    Object? errorMsg = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryStatus,
      arCategory: null == arCategory
          ? _value.arCategory
          : arCategory // ignore: cast_nullable_to_non_nullable
              as List<ArCategory>,
      errorMsg: null == errorMsg
          ? _value.errorMsg
          : errorMsg // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res>
    implements $CategoryNewStateCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CategoryStatus status, List<ArCategory> arCategory, String errorMsg});
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$CategoryNewStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? arCategory = null,
    Object? errorMsg = null,
  }) {
    return _then(_$InitialImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CategoryStatus,
      arCategory: null == arCategory
          ? _value._arCategory
          : arCategory // ignore: cast_nullable_to_non_nullable
              as List<ArCategory>,
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
      {this.status = CategoryStatus.initial,
      final List<ArCategory> arCategory = const [],
      this.errorMsg = 'Failed to load categories'})
      : _arCategory = arCategory;

  @override
  @JsonKey()
  final CategoryStatus status;
  final List<ArCategory> _arCategory;
  @override
  @JsonKey()
  List<ArCategory> get arCategory {
    if (_arCategory is EqualUnmodifiableListView) return _arCategory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_arCategory);
  }

  @override
  @JsonKey()
  final String errorMsg;

  @override
  String toString() {
    return 'CategoryNewState(status: $status, arCategory: $arCategory, errorMsg: $errorMsg)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InitialImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._arCategory, _arCategory) &&
            (identical(other.errorMsg, errorMsg) ||
                other.errorMsg == errorMsg));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_arCategory), errorMsg);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      __$$InitialImplCopyWithImpl<_$InitialImpl>(this, _$identity);
}

abstract class Initial implements CategoryNewState {
  const factory Initial(
      {final CategoryStatus status,
      final List<ArCategory> arCategory,
      final String errorMsg}) = _$InitialImpl;

  @override
  CategoryStatus get status;
  @override
  List<ArCategory> get arCategory;
  @override
  String get errorMsg;
  @override
  @JsonKey(ignore: true)
  _$$InitialImplCopyWith<_$InitialImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
