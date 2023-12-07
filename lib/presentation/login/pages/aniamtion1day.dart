import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/animations/fadeinsclae.dart';
import 'package:size_config/size_config.dart';

import '../../../core/util/device_type.dart';
import '../../../core/util/styles.dart';
import 'login_screen.dart';

class AnimatedBuilderExampleD1 extends StatefulWidget {
  const AnimatedBuilderExampleD1({Key? key}) : super(key: key);

  @override
  AnimatedBuilderExampleD1State createState() =>
      AnimatedBuilderExampleD1State();
}

class AnimatedBuilderExampleD1State extends State<AnimatedBuilderExampleD1>
    with TickerProviderStateMixin {
  //SmartXRLogo
  late final AnimationController _controllerSmartXRLogo;
  late final Animation<double> _animationSmartXRLogo;
  double _opacitySmartXRLogo = 0;
  //Kids Logo
  late AnimationController _controllerKidsLogo;
  late Animation<double> _animationKidsLogo;
  double _opacityKidsLogo = 0;
  double _opacityKidsLogo2 = 0;
  double _opacitySmartXRLogo2 = 0;
  double _opacitySmallCircle = 0;
  double _opacityBigCircle = 0;

  // logos flip out controller
  // late AnimationController _controllerSmartXRLogoOut;
  // late Animation<double> _animationSmartXRLogoOut;

  // late AnimationController _controllerKidsLogoOut;
  // late Animation<double> _animationKidsLogoOut;

  // both logos flip
  late AnimationController _controllerlogosFlip;
  late Animation<double> _animationlogosFlip;
  // circle
  late AnimationController _controllerCircle;
  late Animation<double> _animationCircle;

  late AnimationController _controllerBigCircle;
  late Animation<double> _animationBigCircle;

//opacities
  double _opacityDodoLeg = 0;
  double _opacityForm = 0;
  @override
  void initState() {
    _controllerKidsLogo = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animationKidsLogo = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controllerKidsLogo,
        curve: Curves.easeInOutBack,
      ),
    );

    ////////////////////////////
    _controllerlogosFlip = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationlogosFlip = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controllerlogosFlip,
        curve: Curves.linear,
      ),
    );
    ////////////////////////////
    _controllerCircle =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationCircle =
        CurvedAnimation(parent: _controllerCircle, curve: Curves.easeInOut);

    _controllerBigCircle =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationBigCircle =
        CurvedAnimation(parent: _controllerBigCircle, curve: Curves.easeInOut);

    smartXRLogoInit();

    // kidsLogoInit();
    super.initState();
  }

  @override
  void dispose() {
    _controllerSmartXRLogo.dispose();
    _controllerKidsLogo.dispose();

    // _controllerSmartXRLogoOut.dispose(); // Dispose added controllers
    // _controllerKidsLogoOut.dispose(); // Dispose added controllers
    super.dispose();
  }

  void smartXRLogoInit() async {
    _controllerSmartXRLogo = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animationSmartXRLogo = CurvedAnimation(
        parent: _controllerSmartXRLogo, curve: Curves.linearToEaseOut);

    _controllerSmartXRLogo.forward().then((value) => kidsLogoInit());
    _controllerSmartXRLogo.addListener(() {
      setState(() {
        _opacitySmartXRLogo = 0 + _controllerSmartXRLogo.value;
      });
    });
  }

  void kidsLogoInit() async {
    // _controllerKidsLogo = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 500),
    // );

    // _animationKidsLogo = Tween<double>(begin: 0, end: 0.5).animate(
    //   CurvedAnimation(
    //     parent: _controllerKidsLogo,
    //     curve: Curves.easeInOutBack,
    //   ),
    // );
    _controllerKidsLogo.addListener(() {
      setState(() {
        _opacityKidsLogo = 0 + _controllerKidsLogo.value;
      });
    });
    _controllerKidsLogo.forward().then((value) async {
      //Delay of 0.8 ms
      await Future.delayed(const Duration(milliseconds: 800));

      setState(() {
        _opacitySmartXRLogo = 0;
        _opacityKidsLogo = 0;
        _opacityKidsLogo2 = 1;
        _opacitySmartXRLogo2 = 1;
      });
      _controllerlogosFlip.forward().then((value) {
        //!Circle  Part

        setState(() {
          _opacityKidsLogo2 = 0;
          _opacitySmartXRLogo2 = 0;
          _opacitySmallCircle = 1;
        });

        _controllerCircle.forward().then((value) => {
              // setState(() {
              //   // _opacityKidsLogo2 = 0;
              //   // _opacitySmartXRLogo2 = 0;
              //   _opacitySmallCircle = 0;
              //   _opacityBigCircle = 1;
              //   _controllerBigCircle.forward();
              // })
            });
      });
    });

    // _controllerSmartXRLogo.forward();
    // _controllerSmartXRLogo.addListener(() {
    //   setState(() {
    //     _opacitySmartXRLogo = 0 + _controllerSmartXRLogo.value;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    print(_animationKidsLogo.value);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: AppColors.accentColor,
        body: Padding(
          padding: EdgeInsets.fromLTRB(
              0, DeviceType().isMobile ? 100.h : 80.h, 0, 0),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Opacity(
                  opacity: 1,
                  child: Image.asset(
                    'assets/images/Dog/dog01.png',
                    height: 200.h,
                  ),
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  SizedBox(
                    width: 770.w,
                    child: ScaleTransition(
                      scale: _animationSmartXRLogo,
                      alignment: Alignment.center,
                      child: Opacity(
                        opacity: _opacitySmartXRLogo,
                        child: Image.asset(
                            'assets/images/PNG Icons/SmartXR Logo P.png',
                            width: 770.w),
                      ),
                    ),
                  ),
                  AnimatedBuilder(
                    animation: _animationlogosFlip,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationY(
                            _animationlogosFlip.value * (3.14 / 2)), // Rotation
                        child: Opacity(
                          opacity: _opacitySmartXRLogo2,
                          child: SizedBox(
                            width: 770.w,
                            child: Image.asset(
                                'assets/images/PNG Icons/SmartXR Logo P.png',
                                width: 770.w),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 23.h,
                    child: SizedBox(
                      width: 500.w,
                      child: AnimatedBuilder(
                        animation: _animationKidsLogo,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.rotationY(
                                _animationKidsLogo.value * 6.28),
                            child: child,
                            alignment: Alignment.center,
                          );
                        },
                        child: Opacity(
                          opacity: _opacityKidsLogo,
                          child: Image.asset(
                              'assets/images/PNG Icons/kids 1.png',
                              width: 770.w),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 23.h,
                    child: SizedBox(
                      width: 500.w,
                      child: AnimatedBuilder(
                        animation: _animationlogosFlip,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.rotationY(
                                _animationlogosFlip.value * (3.14 / 2)),
                            child: child,
                            alignment: Alignment.center,
                          );
                        },
                        child: Opacity(
                          opacity: _opacityKidsLogo2,
                          child: Image.asset(
                              'assets/images/PNG Icons/kids 1.png',
                              width: 770.w),
                        ),
                      ),
                    ),
                  ),

                  // //! Circle Big
                  Positioned(
                    top: 25.h,
                    child: AnimatedBuilder(
                        animation: _animationBigCircle,
                        builder: (context, _) {
                          return Container(
                            // color: Colors.red,
                            width: 100.w + _controllerBigCircle.value,
                            height: 100.w + _controllerBigCircle.value,

                            child: Opacity(
                              opacity: _opacityBigCircle,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    shape: BoxShape.circle),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          );
                        }),
                  ), //! Circle
                  Positioned(
                    top: 25.h,
                    child: AnimatedBuilder(
                        animation: _animationCircle,
                        builder: (context, _) {
                          return Container(
                            // color: Colors.red,
                            width: 500.w * 6.5 * _controllerCircle.value,
                            height: 500.w * 6.5 * _controllerCircle.value,

                            child: Opacity(
                              opacity: _opacitySmallCircle,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    shape: BoxShape.circle),
                                // height: 100,
                                // width: 100,
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
              Opacity(opacity: _opacityForm, child: loginForm()),
              Opacity(
                opacity: _opacityDodoLeg,
                child: Positioned(
                  top: 140.h,
                  child: Image.asset(
                    'assets/images/Dog/dog03.png',
                    height: 100.h,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Opacity(
                opacity: 1,
                child: Positioned(
                  top: 150.h,
                  child: Image.asset(
                    'assets/images/Dog/Paws.png',
                    height: 100.h,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

Column loginForm() {
  return Column(
    children: [
      SizedBox(height: 70.h),
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
