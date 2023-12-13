part of 'guest_validation_bloc.dart';

@freezed
class GuestValidationState with _$GuestValidationState {
  const factory GuestValidationState({
    @Default(GuestName.pure()) GuestName guestName,
    @Default(PhoneNumber.pure()) PhoneNumber phoneNumber,
    @Default(false) bool isValid,
    @Default(FormzSubmissionStatus.initial) FormzSubmissionStatus status,
  }) = Initial;
}
