import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter/widgets.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthenticationRepository authenticationRepository;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String verificaitonIdL = '';
  LoginBloc(this.authenticationRepository) : super(const LoginState()) {
    on<LoginEvent>((events, emit) async {
      await events.map(
        requestOtp: (event) async => await _requestOtp(event, emit),
        checkMobileNoExists: (event) async =>
            await _checkMobileNoExists(event, emit),
        phoneNumberAuth: (event) async => await _phoneNumberAuth(event, emit),
        updateStatus: (event) async => await _updateStatus(event, emit),
        verifyOtp: (event) async => await _verifyOtp(event, emit),
        error: (event) async => await _error(event, emit),
        guestLogin: (event) async => await _guestLogin(event, emit),
        resendOtp: (_) async => await _resendOtp(emit),
      );
    });
  }

  _requestOtp(RequestOtp event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.otp2));
      debugPrint('Requested otp');
    } catch (e) {
      add(LoginEvent.error(errorMessage: '$e'));
    }
  }

  _verifyOtp(VerifyOtp event, Emitter<LoginState> emit) async {
    try {
      debugPrint('Verify Otp');
      emit(state.copyWith(status: LoginStatus.loading));
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificaitonIdL, smsCode: event.smsCode);

      // Sign the user in (or link) with the credential
      var resu = await _firebaseAuth.signInWithCredential(credential);
      if (resu.user != null) {
        await authenticationRepository.saveDataToHive(state.mobileNumber);
        //Save to hivebox
        if (state.isGuest) {
          //Todo:Implement Succes state UI

          await authenticationRepository.sendGuestDataToServer(
              guestName: state.parentName, guestPhone: state.mobileNumber);

          emit(state.copyWith(status: LoginStatus.phoneNo1));
        } else {
          emit(state.copyWith(status: LoginStatus.success));
        }
      }
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.wrongOtp));

      // add(LoginEvent.error(errorMessage: '$e'));
    }
  }

  _checkMobileNoExists(
      CheckMobileNoExists event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      var isExists =
          await authenticationRepository.checkMobNoExists(event.mobileNumber);
      print(isExists);
      emit(state.copyWith(status: LoginStatus.phoneNo1));

      if (isExists) {
        // add(LoginEvent.phoneNumberAuth(mobileNumber: event.mobileNumber));
        debugPrint('checking ${event.mobileNumber}');
        add(LoginEvent.phoneNumberAuth(mobileNumber: event.mobileNumber));
        // AuthenticationRepository().getParentId(event.mobileNumber);
        // AuthenticationRepository().getstudentprofilesnew();
        // AuthenticationRepository().getallstandardsofschool();
        // await authenticationRepository.saveDataToHive(event.mobileNumber);
      } else {
        add(const LoginEvent.error(
            errorMessage: 'Your mobile is not registered!'));
        debugPrint('phone number not exists');
      }
    } catch (e) {
      add(LoginEvent.error(errorMessage: '$e'));
    }
  }

  _phoneNumberAuth(PhoneNumberAuth event, Emitter<LoginState> emit) async {
    debugPrint('inside pohone no auth ${event.mobileNumber}');
    try {
      emit(state.copyWith(
          status: LoginStatus.loading, mobileNumber: event.mobileNumber));

      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91${event.mobileNumber}',
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          add(const LoginEvent.error(errorMessage: 'Verification Failed!'));

          debugPrint(
              'verificationFailed for mob no: ${event.mobileNumber} with error ${e.toString()}');
        },
        codeSent: (String verificationId, int? resendToken) async {
          verificaitonIdL = verificationId;
          add(LoginEvent.requestOtp(
              verificationId: verificationId, resendToken: resendToken));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      add(const LoginEvent.error(errorMessage: 'Wrong OTP entered'));
    }
  }

  _updateStatus(UpdateStatus event, Emitter<LoginState> emit) {
    emit(state.copyWith(status: event.status));
  }

  _error(LoginError event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        status: LoginStatus.error, errorMessage: event.errorMessage));
  }

  _guestLogin(GuestLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(
        isGuest: true,
        parentName: event.parentsName,
        mobileNumber: event.mobileNumber));
    add(LoginEvent.phoneNumberAuth(mobileNumber: event.mobileNumber));
  }

  _resendOtp(Emitter<LoginState> emit) async {
    add(LoginEvent.phoneNumberAuth(mobileNumber: state.mobileNumber));
  }
}
