import 'package:bloc/bloc.dart';
import 'package:flutter_ar/data/models/student_profile_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'student_profile_state.dart';
part 'student_profile_cubit.freezed.dart';

class StudentProfileCubit extends Cubit<StudentProfileState> {
  StudentProfileCubit() : super(StudentProfileState.initial());

  void initProfile(StudentProfileModel? profile) {
    if (profile != null) {
      print('profile initialslize');
      emit(state.copyWith(
          status: StudentProfileStauts.loaded, studentProfileModel: profile));
    }
  }
}
