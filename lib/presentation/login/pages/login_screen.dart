import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ar/domain/repositories/authentication_repository.dart';
import 'package:flutter_ar/main.dart';
import 'package:flutter_ar/presentation/main_menu/main_menu_screen.dart';
import 'package:flutter_ar/presentation/splash_screen/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restart_app/restart_app.dart';
import 'package:size_config/size_config.dart';

import '../../../core/reusable_widgets/network_disconnected.dart';
import '../../../core/student_profile_cubit/student_profile_cubit.dart';
import '../../../core/util/animations/login_screen_animation_controller.dart';
import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import '../bloc/login_bloc/login_bloc.dart';
import '../widgets/login_page1_mobile_numbaer.dart';
import '../widgets/login_page2_otp.dart';
import '../widgets/login_page3_parent_details.dart';
import '../widgets/login_page4_guest.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final LoginScreenAnimationController _animationController;

  @override
  void initState() {
    _animationController = LoginScreenAnimationController(this);
    _animationController.initializeAnimations();
    _animationController.controller.addListener(() {
      setState(() {});
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(systemNavigationBarColor: AppColors.accentColor));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      // DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: const Color(0XffD1CBF9),
        body: ConnectionNotifierToggler(
          disconnected: const NetworkDisconnected(),
          connected: Padding(
            padding: EdgeInsets.fromLTRB(
                0, DeviceType().isMobile ? 0.h : 80.h, 0, 0),
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: 0.h,
                  child: Transform.translate(
                    offset: Offset(
                        0, _animationController.animationDodoTranslate.value.h),
                    child: Visibility(
                      visible: _animationController.animationDodoVisible.value,
                      child: Image.asset(
                        'assets/images/Dog/Dodo Animation.gif',
                        height: 350.h,
                        width: 350.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 260.h),
                      Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.topCenter,
                        children: [
                          Opacity(
                            opacity: _animationController.opacityLogos.value,
                            child: Transform(
                              transform: Matrix4.rotationY(_animationController
                                      .flipLogosAnimation.value *
                                  -1 *
                                  3 *
                                  3.14 /
                                  6)
                                ..setEntry(3, 2, 0.001),
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 1900.w *
                                    _animationController
                                        .sizeAnimationSmartXRLogo.value,
                                child: Opacity(
                                  opacity: _animationController
                                      .opacityAnimationSmartXRLogo.value,
                                  child: Image.asset(
                                      'assets/images/PNG Icons/SmartXR Logo P.png',
                                      width: 770.w),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 50.h,
                            child: Opacity(
                              opacity: _animationController.opacityLogos.value,
                              child: Transform(
                                // origin: Offset(dx, dy),
                                transform: Matrix4.rotationY(
                                    _animationController
                                            .flipLogosAnimation.value *
                                        -1 *
                                        3 *
                                        3.14 /
                                        6)
                                  ..setEntry(3, 2, 0.001),
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 990.w,
                                  // height: 2000.h,
                                  child: Opacity(
                                    opacity: _animationController
                                        .opacityAnimationKidsLogo.value,
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(
                                          _animationController
                                              .rotateAnimationKidsLogo.value),
                                      child: Image.asset(
                                        'assets/images/PNG Icons/kids_1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 28.h,
                            child: SizedBox(
                              height:
                                  _animationController.animationCircle.value,
                              width: _animationController.animationCircle.value,
                              child: Opacity(
                                opacity:
                                    _animationController.opacityCircle.value,
                                child: CircleAvatar(
                                  backgroundColor: AppColors.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            child: Transform.translate(
                              offset: -_animationController.animationPaws.value,
                              child: Opacity(
                                opacity: _animationController.opacityPaws.value,
                                child: Image.asset(
                                  'assets/images/Dog/Paws_First-Login.png',
                                  width: 420.h +
                                      _animationController
                                          .animationPawsStreatch.value,
                                  height: 90.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Opacity(
                          opacity: _animationController.opacityLoginForm.value,
                          child: BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) async {
                              if (state.status == LoginStatus.error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(state.errorMessage)));
                                context.read<LoginBloc>().add(
                                    const LoginEvent.updateStatus(
                                        status: LoginStatus.phoneNo1));
                              }
                              if (state.status == LoginStatus.wrongOtp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Wrong OTP entered")));
                              }
                              if (state.status == LoginStatus.success) {
                                debugPrint('success state');
                                Restart.restartApp();
                              }
                            },
                            builder: (context, state) {
                              switch (state.status) {
                                case LoginStatus.loading:
                                  return const Center(
                                      child: CircularProgressIndicator.adaptive(
                                    strokeCap: StrokeCap.round,
                                  ));
                                case LoginStatus.phoneNo1:
                                  return const LoginPage1MobileNumber();
                                case LoginStatus.otp2:
                                  return const LoginPage2Otp();
                                case LoginStatus.wrongOtp:
                                  return const LoginPage2Otp();
                                case LoginStatus.parents3:
                                  return const LoginPage3ParentDetails();
                                case LoginStatus.guest:
                                  return const LoginPage4Guest();
                                case LoginStatus.error:
                                  return const Center(
                                      child: Text("Error on login"));
                                case LoginStatus.success:
                                  return const Center(
                                      child: CircularProgressIndicator.adaptive(
                                    strokeCap: StrokeCap.round,
                                  ));
                              }
                            },
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: 140.h,
                  child: Opacity(
                    opacity: 0,
                    child: Image.asset(
                      'assets/images/Dog/dog03.png',
                      height: 100.h,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
