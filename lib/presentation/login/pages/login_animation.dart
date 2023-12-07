import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'dart:math';
import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import 'login_screen.dart';

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({Key? key}) : super(key: key);

  @override
  AnimatedBuilderExampleState createState() => AnimatedBuilderExampleState();
}

class AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeAnimationSmartXRLogo;
  late final Animation<double> _opacityAnimationSmartXRLogo;
  late final Animation<double> _rotateAnimationKidsLogo;
  late final Animation<double> _opacityAnimationKidsLogo;
  late final Animation<double> _flipLogosAnimation;
  late final Animation<double> _opacityCircle;
  late final Animation<double> _animationCircle;
  late final Animation<double> _opacityPaws;
  late final Animation<Offset> _animationPaws;
  late final Animation<double> _animationPawsStreatch;
  late final Animation<bool> _animationDodoVisible;
  late final Animation<double> _animationDodoTranslate;
  late final Animation<double> _opacityLoginForm;
  bool dodoVisible = false;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5900),
      vsync: this,
    );

    _sizeAnimationSmartXRLogo = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.17, curve: Curves.easeOut),
      ),
    );
    _opacityAnimationSmartXRLogo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.17, curve: Curves.easeOut),
      ),
    );
    _rotateAnimationKidsLogo = Tween<double>(begin: 3.14, end: 6.28).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.17, 0.31, curve: Curves.bounceOut),
      ),
    );
    _opacityAnimationKidsLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.17, 0.31, curve: Curves.easeOut),
      ),
    );

    _flipLogosAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.306, 0.34, curve: Curves.easeOut),
      ),
    );

    _opacityCircle = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.35, 0.386, curve: Curves.linear),
      ),
    );

    _animationCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 60.h), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 60.h, end: 50.h), weight: 2),
      // TweenSequenceItem(tween: Tween(begin: 50.h, end: 100.h), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 1400.h), weight: 2),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.386, 0.483, curve: Curves.easeIn),
      ),
    );

    _opacityPaws = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.483, 0.483, curve: Curves.linear),
      ),
    );
    _animationPaws = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 0.h), end: Offset(0, 190.h)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 190.h), end: Offset(0, 0.h)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.483, 0.55, curve: Curves.easeIn),
      ),
    );
    _animationPawsStreatch = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 20), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.58, curve: Curves.easeInOut),
      ),
    );
    _animationDodoVisible = Tween<bool>(begin: false, end: true).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 0.58, curve: Curves.linear),
      ),
    );
    _animationDodoTranslate = Tween<double>(begin: 220, end: -40).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.58, 0.64, curve: Curves.linear),
      ),
    );
    _opacityLoginForm = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.64, 0.8, curve: Curves.linear),
      ),
    );
    /////////////////////////////
    ///
    _controller.forward().then((value) => dodoVisible = true);
    // _controller.repeat();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_animationPaws.value);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: Color(0XffD1CBF9),
        body: Padding(
          padding:
              EdgeInsets.fromLTRB(0, DeviceType().isMobile ? 0.h : 80.h, 0, 0),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 0.h,
                child: Transform.translate(
                  offset: Offset(0, _animationDodoTranslate.value.h),
                  child: Visibility(
                    visible: _animationDodoVisible.value,
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
                        Transform(
                          transform: Matrix4.rotationY(
                              _flipLogosAnimation.value * -1 * 3 * 3.14 / 6)
                            ..setEntry(3, 2, 0.001),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 1900.w * _sizeAnimationSmartXRLogo.value,
                            child: Opacity(
                              opacity: _opacityAnimationSmartXRLogo.value,
                              child: Image.asset(
                                  'assets/images/PNG Icons/SmartXR Logo P.png',
                                  width: 770.w),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 50.h,
                          child: Transform(
                            // origin: Offset(dx, dy),
                            transform: Matrix4.rotationY(
                                _flipLogosAnimation.value * -1 * 3 * 3.14 / 6)
                              ..setEntry(3, 2, 0.001),
                            alignment: Alignment.center,
                            child: SizedBox(
                              width: 990.w,
                              // height: 2000.h,
                              child: Opacity(
                                opacity: _opacityAnimationKidsLogo.value,
                                child: Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.rotationY(
                                      _rotateAnimationKidsLogo.value),
                                  child: Image.asset(
                                    'assets/images/PNG Icons/kids 1.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 28.h,
                          child: SizedBox(
                            height: _animationCircle.value,
                            width: _animationCircle.value,
                            child: Opacity(
                              opacity: _opacityCircle.value,
                              child: CircleAvatar(
                                backgroundColor: AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: Transform.translate(
                            offset: -_animationPaws.value,
                            child: Opacity(
                              opacity: _opacityPaws.value,
                              child: Image.asset(
                                'assets/images/Dog/Paws_First-Login.png',
                                width: 420.h + _animationPawsStreatch.value,
                                height: 90.h,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Opacity(
                        opacity: _opacityLoginForm.value, child: loginForm()),
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
        ));
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
            ? AppTextStyles.nunito110w400white
            : AppTextStyles.nunito56w400white,
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
            ? AppTextStyles.nunito110w400white
            : AppTextStyles.nunito56w400white,
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
