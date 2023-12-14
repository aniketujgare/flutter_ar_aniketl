import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:size_config/size_config.dart';

import '../../core/util/animations/splash_screen_animation_controller.dart';
import '../../core/util/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final SplashScreenAnimationController _animationController;

  @override
  void initState() {
    _animationController = SplashScreenAnimationController(this);
    _animationController.initializeAnimations();
    _animationController.controller.addListener(() {
      setState(() {});
    });
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    _animationController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_animationPaws.value);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0XffD1CBF9),
        body: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 195.h,
              child: Opacity(
                opacity: _animationController.opacityLogos.value,
                child: Transform(
                  transform: Matrix4.rotationY(
                    _animationController.flipLogosAnimation.value *
                        -1 *
                        3 *
                        3.14 /
                        6,
                  )..setEntry(3, 2, 0.001),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity:
                        _animationController.opacityAnimationSmartXRLogo.value,
                    child: Image.asset(
                        'assets/images/PNG Icons/SmartXR Logo P.png',
                        width: 2200.w),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 250.h,
              child: Transform(
                transform: Matrix4.rotationY(
                    _animationController.flipLogosAnimation.value *
                        -1 *
                        3 *
                        3.14 /
                        6)
                  ..setEntry(3, 2, 0.001),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _animationController.opacityLogos.value,
                  child: SizedBox(
                    width: 1110.w,
                    // height: 2000.h,
                    child: Opacity(
                      opacity:
                          _animationController.opacityAnimationKidsLogo.value,
                      child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            _animationController.rotateAnimationKidsLogo.value),
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

            //!BIg Circile
            Align(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 7.h * _animationController.animationOuterCircle.value,
                // origin: Offset(12, 12),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _animationController.opacityCircle.value,
                  child: CircleAvatar(
                    radius: 5.h,
                    backgroundColor: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            //!Small Circile

            Align(
              alignment: Alignment.center,
              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(20.h),
                  width: _animationController.animationInnerCircle.value,
                  height: _animationController.animationInnerCircle.value,
                  color: AppColors.accentColor,
                  child: Positioned(
                    top: 0.h,
                    child: Visibility(
                      visible: _animationController.animationDodoVisible.value,
                      child: Transform.translate(
                        offset: Offset(0,
                            _animationController.animationDodoTranslate.value),
                        child: Image.asset(
                          'assets/images/Dog/Dodo Animation.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ), // Adjust the color as needed
                ),
              ),
            ),

            Positioned(
              top: 0,
              child: Transform.translate(
                offset: _animationController.animationPaws.value,
                child: Opacity(
                  opacity: _animationController.opacityPaws.value,
                  child: Image.asset(
                    'assets/images/Dog/Paws_Splash-Screen.png',
                    width: 305.h +
                        _animationController.animationPawsStreatch.value,
                    height: 75.h,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.center,
              child: Transform.scale(
                scale: 1.2,
                // origin: Offset(12, 12),
                alignment: Alignment.center,
                child: AnimatedBuilder(
                  animation: _animationController.irisAnimation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper:
                          IrisClipper(_animationController.irisAnimation.value),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                        child: Container(
                          // width: 400.h,
                          // height: 400.h,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            Opacity(
                opacity: _animationController.opacityProfileForm.value,
                child: profileChooseForm(context)),
          ],
        ));
  }

  Container profileChooseForm(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(2 * pi -
                (pi / 3 - _animationController.animationFlipProfileForm.value)),
            child: Text(
              'My name is...',
              style: AppTextStyles.unitedRounded140w700
                  .copyWith(fontSize: 44, color: AppColors.accentColor),
            ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(2 * pi -
                      (pi / 3 -
                          _animationController.animationFlipProfile1.value)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/PNG Icons/CustomButtons001.png',
                        height: 115.h,
                      ),
                      Text(
                        'Shardul',
                        style: AppTextStyles.unitedRounded140w700.copyWith(
                            height: 1.8,
                            fontSize: 120.sp,
                            color: AppColors.accentColor),
                      ),
                    ],
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(2 * pi -
                      (pi / 3 -
                          _animationController.animationFlipProfile2.value)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/PNG Icons/CustomButtons001.png',
                        height: 115.h,
                      ),
                      Text(
                        'Sneha',
                        style: AppTextStyles.unitedRounded140w700.copyWith(
                            height: 1.8,
                            fontSize: 120.sp,
                            color: AppColors.accentColor),
                      ),
                    ],
                  ),
                ),
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(2 * pi -
                      (pi / 3 -
                          _animationController.animationFlipProfile3.value)),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/PNG Icons/CustomButtons001.png',
                        height: 115.h,
                      ),
                      Text(
                        'Person 1',
                        style: AppTextStyles.unitedRounded140w700.copyWith(
                            height: 1.8,
                            fontSize: 120.sp,
                            color: AppColors.accentColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.18),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(2 * pi -
                (pi / 3 - _animationController.animationFlipProfileForm.value)),
            child: Text(
              'SmartXR School',
              style: AppTextStyles.unitedRounded140w700
                  .copyWith(fontSize: 120.sp, color: AppColors.accentColor),
            ),
          ),
        ],
      ),
    );
  }
}

class IrisClipper extends CustomClipper<Path> {
  final double progress;

  IrisClipper(this.progress);

  @override
  Path getClip(Size size) {
    double radius = size.width / 2;

    double centerX = size.width / 2;
    double centerY = size.height / 2;

    double innerRadius = radius * progress;

    Path path = Path()
      ..addOval(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
      ..addOval(Rect.fromCircle(
          center: Offset(centerX, centerY), radius: innerRadius))
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
