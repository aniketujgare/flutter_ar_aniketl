import 'package:bloc/bloc.dart';
import '../../../../data/models/phone_number.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_validation_event.dart';
part 'login_validation_state.dart';
part 'login_validation_bloc.freezed.dart';

class LoginValidationBloc
    extends Bloc<LoginValidationEvent, LoginValidationState> {
  LoginValidationBloc() : super(const LoginValidationState()) {
    on<LoginValidationEvent>((events, emit) {
      events.map(
          phoneNumberChanged: (event) => _phoneNumberChanged(event, emit),
          phoneNumberSubmitted: (event) => _phoneNumberSubmitted(event, emit));
    });
  }

  _phoneNumberChanged(
      PhoneNumberChanged event, Emitter<LoginValidationState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid
            ? phoneNumber
            : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([phoneNumber]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  _phoneNumberSubmitted(
      PhoneNumberSubmitted event, Emitter<LoginValidationState> emit) async {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        isValid: Formz.validate([phoneNumber]),
        status: FormzSubmissionStatus.initial,
      ),
    );
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } else {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
    print('validation status ' + state.status.toString());
  }
}
