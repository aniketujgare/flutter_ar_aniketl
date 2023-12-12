import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:size_config/size_config.dart';
import 'dart:math';
import '../../core/util/device_type.dart';
import '../../core/util/reusable_widgets/reusable_button.dart';
import '../../core/util/reusable_widgets/reusable_textfield.dart';
import '../../core/util/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacityAnimationSmartXRLogo;
  late final Animation<double> _rotateAnimationKidsLogo;
  late final Animation<double> _opacityAnimationKidsLogo;
  late final Animation<double> _flipLogosAnimation;
  late final Animation<double> _opacityLogos;
  late final Animation<double> _opacityCircle;
  late final Animation<double> _animationOuterCircle;
  late final Animation<double> _animationInnerCircle;
  late final Animation<double> _opacityPaws;
  late final Animation<Offset> _animationPaws;
  late final Animation<double> _animationPawsStreatch;
  late final Animation<bool> _animationDodoVisible;
  late final Animation<double> _animationDodoTranslate;
  late final Animation<double> _irisAnimation;
  late final Animation<double> _opacityProfileForm;
  late final Animation<double> _animationFlipProfileForm;
  late final Animation<double> _animationFlipProfile1;
  late final Animation<double> _animationFlipProfile2;
  late final Animation<double> _animationFlipProfile3;

  double addTime = 0.15;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 7700),
      vsync: this,
    );

    _opacityAnimationSmartXRLogo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.076075, curve: Curves.easeOut),
      ),
    );
    _opacityAnimationKidsLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.076075, 0.076075, curve: Curves.easeOut),
      ),
    );
    _rotateAnimationKidsLogo = Tween<double>(begin: 3.14, end: 6.28).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.076075, 0.1371, curve: Curves.bounceOut),
      ),
    );

    _flipLogosAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2663, 0.2790, curve: Curves.easeOut),
      ),
    );
    _opacityLogos = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2782, 0.2790, curve: Curves.easeOut),
      ),
    );
    _opacityCircle = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2782, 0.2790, curve: Curves.linear),
      ),
    );

    _animationOuterCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.2), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1), weight: 2),
      // TweenSequenceItem(tween: Tween(begin: 50.h, end: 100.h), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 17), weight: 2),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2790, 0.4, curve: Curves.easeIn),
      ),
    );
    _animationInnerCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.h, end: 0.h), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 380.h), weight: 100),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.45, curve: Curves.easeIn),
      ),
    );
    _opacityPaws = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.45, curve: Curves.linear),
      ),
    );
    _animationPaws = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 390.h), end: Offset(0, 320.h)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 320.h), end: Offset(0, 390.h)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 0.48, curve: Curves.easeIn),
      ),
    );
    _animationPawsStreatch = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 20), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.48, 0.55, curve: Curves.easeInOut),
      ),
    );
    _animationDodoVisible = Tween<bool>(begin: false, end: true).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.55, curve: Curves.linear),
      ),
    );
    _animationDodoTranslate = Tween<double>(begin: 220, end: 15).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 0.58, curve: Curves.linear),
      ),
    );

    _irisAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.9, 0.93, curve: Curves.linear),
      ),
    );
    _opacityProfileForm = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.93, 0.93, curve: Curves.linear),
      ),
    );
    _animationFlipProfileForm = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.93, 1, curve: Curves.easeInOut),
      ),
    );
    _animationFlipProfile1 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.93, 0.95, curve: Curves.easeInOut),
      ),
    );
    _animationFlipProfile2 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.95, 0.97, curve: Curves.easeInOut),
      ),
    );
    _animationFlipProfile3 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.97, 1, curve: Curves.easeInOut),
      ),
    );
    // _opacityLoginForm = Tween<double>(begin: 0, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: const Interval(0.64, 0.8, curve: Curves.linear),
    //   ),
    // );
    /////////////////////////////
    ///
    _controller.forward();
    // _controller.repeat();
    _controller.addListener(() {
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
    _controller.dispose();

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
                opacity: _opacityLogos.value,
                child: Transform(
                  transform: Matrix4.rotationY(
                      _flipLogosAnimation.value * -1 * 3 * 3.14 / 6)
                    ..setEntry(3, 2, 0.001),
                  alignment: Alignment.center,
                  child: Opacity(
                    opacity: _opacityAnimationSmartXRLogo.value,
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
                    _flipLogosAnimation.value * -1 * 3 * 3.14 / 6)
                  ..setEntry(3, 2, 0.001),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _opacityLogos.value,
                  child: SizedBox(
                    width: 1110.w,
                    // height: 2000.h,
                    child: Opacity(
                      opacity: _opacityAnimationKidsLogo.value,
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Matrix4.rotationY(_rotateAnimationKidsLogo.value),
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
                scale: 7.h * _animationOuterCircle.value,
                // origin: Offset(12, 12),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _opacityCircle.value,
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
                  width: _animationInnerCircle.value,
                  height: _animationInnerCircle.value,
                  color: AppColors.accentColor,
                  child: Positioned(
                    top: 0.h,
                    child: Visibility(
                      visible: _animationDodoVisible.value,
                      child: Transform.translate(
                        offset: Offset(0, _animationDodoTranslate.value),
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
                offset: _animationPaws.value,
                child: Opacity(
                  opacity: _opacityPaws.value,
                  child: Image.asset(
                    'assets/images/Dog/Paws_Splash-Screen.png',
                    width: 305.h + _animationPawsStreatch.value,
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
                  animation: _irisAnimation,
                  builder: (context, child) {
                    return ClipPath(
                      clipper: IrisClipper(_irisAnimation.value),
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
                opacity: _opacityProfileForm.value,
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
            transform: Matrix4.rotationY(
                2 * pi - (pi / 3 - _animationFlipProfileForm.value)),
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
                  transform: Matrix4.rotationY(
                      2 * pi - (pi / 3 - _animationFlipProfile1.value)),
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
                  transform: Matrix4.rotationY(
                      2 * pi - (pi / 3 - _animationFlipProfile2.value)),
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
                  transform: Matrix4.rotationY(
                      2 * pi - (pi / 3 - _animationFlipProfile3.value)),
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
            transform: Matrix4.rotationY(
                2 * pi - (pi / 3 - _animationFlipProfileForm.value)),
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

class ExpampleWidget extends StatefulWidget {
  const ExpampleWidget({
    super.key,
  });

  @override
  State<ExpampleWidget> createState() => _ExpampleWidgetState();
}

class _ExpampleWidgetState extends State<ExpampleWidget> {
  @override
  Widget build(BuildContext context) {
    double _sliderValue = 0;
    return Scaffold(
      body: Column(
        children: [
          Slider(
            value: _sliderValue,
            onChanged: (value) {
              setState(() {
                _sliderValue = value;
                print(_sliderValue);
              });
            },
            min: 0.0,
            max: 100.0,
            divisions: 100, // Optional: Number of divisions between min and max
            label: '$_sliderValue',
          ),
          Transform(
            transform: Matrix4.rotationY(-pi * 80),
            alignment: Alignment.center,
            child: SizedBox(
              width: 500.w,
              child: Opacity(
                opacity: 1,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(180 / pi * _sliderValue),
                  child: Image.asset('assets/images/PNG Icons/kids 1.png',
                      width: 770.w),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Column loginForm() {
  return Column(
    children: [
      SizedBox(height: 20.h),
      Text(
        'Welcome!',
        textAlign: TextAlign.center,
        style: DeviceType().isMobile
            ? AppTextStyles.unitedRounded270w700
            : AppTextStyles.unitedRounded140w700,
      ),
      SizedBox(height: 25.h),
      Text(
        'Enter your mobile number to login',
        textAlign: TextAlign.center,
        style: DeviceType().isMobile
            ? AppTextStyles.nunito95w400white
            : AppTextStyles.nunito100w400white,
      ),
      SizedBox(
        height: 20.h,
      ),
      const ReusableTextField(),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        width: 2000.w,
        height: 75.h,
        child: ReusableButton(
          buttonColor: AppColors.primaryColor,
          text: 'Send OTP',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
      SizedBox(
        height: 70.h,
      ),
      Text(
        'or continue as guest ',
        textAlign: TextAlign.center,
        style: DeviceType().isMobile
            ? AppTextStyles.nunito95w400white
            : AppTextStyles.nunito100w400white,
      ),
      SizedBox(
        height: 20.h,
      ),
      SizedBox(
        width: 2000.w,
        height: 75.h,
        child: ReusableButton(
          text: 'Guest',
          buttonColor: AppColors.accentColor,
          textColor: AppColors.primaryColor,
          onPressed: () {},
        ),
      ),
    ],
  );
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
