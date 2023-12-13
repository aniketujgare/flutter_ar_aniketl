part of 'guest_validation_bloc.dart';

@freezed
class GuestValidationEvent with _$GuestValidationEvent {
  const factory GuestValidationEvent.phoneNumberChanged(
      {required String phoneNumber}) = PhoneNumberChanged;
  const factory GuestValidationEvent.guestNameChanged(
      {required String guestName}) = GuestNameChanged;
  const factory GuestValidationEvent.guestFormSubmitted() = GuestFormSubmitted;
}
