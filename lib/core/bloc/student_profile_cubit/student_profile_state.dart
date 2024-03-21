part of 'student_profile_cubit.dart';

enum StudentProfileStauts { initial, loading, loaded, error }

@freezed
class StudentProfileState with _$StudentProfileState {
  const factory StudentProfileState.initial({
    @Default(null) StudentProfileModel? studentProfileModel,
    @Default(StudentProfileStauts.initial) status,
  }) = Initial;
}
