import 'package:flutter/material.dart';
import 'package:flutter_ar/presentation/animations/fadeinsclae.dart';
import 'package:size_config/size_config.dart';

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
  //SmartXRLogo
  late final AnimationController _controllerSmartXRLogo;
  late final Animation<double> _animationSmartXRLogo;
  double _opacitySmartXRLogo = 0;
  //Kids Logo
  late AnimationController _controllerKidsLogo;
  late Animation<double> _animationKidsLogo;
  double _opacityKidsLogo = 0;

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
    smartXRLogoInit();
    // kidsLogoInit();
    super.initState();
  }

  @override
  void dispose() {
    _controllerSmartXRLogo.dispose();
    _controllerKidsLogo.dispose();
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

    // _animationKidsLogo = Tween<double>(begin: 0.5, end: 1).animate(
    //   CurvedAnimation(
    //     parent: _controllerKidsLogo,
    //     curve: Curves.easeInOutBack,
    //   ),
    // );
    _controllerKidsLogo.forward();
    _controllerKidsLogo.addListener(() {
      setState(() {
        _opacityKidsLogo = 0 + _controllerKidsLogo.value;
      });
    });
    await Future.delayed(const Duration(milliseconds: 1600), () {
      // _opacityKidsLogo = 1;
    });
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
                  opacity: _opacityDodoLeg,
                  child: Image.asset(
                    'assets/images/Dog/dog01.png',
                    height: 200.h,
                  ),
                ),
              ),
              RotatedBox(
                quarterTurns: 4,
                child: ClipPath(
                  clipper: CurvedTopRectangleClipper(),
                  child: Container(
                    color: AppColors.accentColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 280.h),
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
                            ],
                          ),
                          Opacity(opacity: _opacityForm, child: loginForm()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                opacity: _opacityDodoLeg,
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
