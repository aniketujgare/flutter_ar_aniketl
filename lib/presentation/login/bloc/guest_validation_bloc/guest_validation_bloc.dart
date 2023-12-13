import 'package:bloc/bloc.dart';
import 'package:flutter_ar/data/models/guest_name.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/models/phone_number.dart';

part 'guest_validation_event.dart';
part 'guest_validation_state.dart';
part 'guest_validation_bloc.freezed.dart';

class GuestValidationBloc
    extends Bloc<GuestValidationEvent, GuestValidationState> {
  GuestValidationBloc() : super(const GuestValidationState()) {
    on<GuestValidationEvent>((events, emit) async {
      await events.map(
        phoneNumberChanged: (event) => _phoneNumberChanged(event, emit),
        guestNameChanged: (event) => _guestNameChanged(event, emit),
        guestFormSubmitted: (event) => _guestFormSubmitted(event, emit),
      );
    });
  }

  _phoneNumberChanged(
      PhoneNumberChanged event, Emitter<GuestValidationState> emit) {
    final phoneNumber = PhoneNumber.dirty(event.phoneNumber);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber.isValid
            ? phoneNumber
            : PhoneNumber.pure(event.phoneNumber),
        isValid: Formz.validate([phoneNumber, state.guestName]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  _guestNameChanged(
      GuestNameChanged event, Emitter<GuestValidationState> emit) {
    final guestName = GuestName.dirty(event.guestName);
    emit(
      state.copyWith(
        guestName:
            guestName.isValid ? guestName : GuestName.pure(event.guestName),
        isValid: Formz.validate([state.phoneNumber, guestName]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  _guestFormSubmitted(
      GuestFormSubmitted event, Emitter<GuestValidationState> emit) async {
    final phoneNumber = PhoneNumber.dirty(state.phoneNumber.value);
    final guestName = GuestName.dirty(state.guestName.value);
    emit(
      state.copyWith(
        phoneNumber: phoneNumber,
        guestName: guestName,
        isValid: Formz.validate([phoneNumber, guestName]),
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
