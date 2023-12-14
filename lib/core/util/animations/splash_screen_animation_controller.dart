import 'package:flutter/animation.dart';
import 'package:size_config/size_config.dart';

import '../../../presentation/splash_screen/splash_screen.dart';

class SplashScreenAnimationController {
  final SplashScreenState state;

  SplashScreenAnimationController(this.state);
  late final AnimationController controller;
  late final Animation<double> opacityAnimationSmartXRLogo;
  late final Animation<double> rotateAnimationKidsLogo;
  late final Animation<double> opacityAnimationKidsLogo;
  late final Animation<double> flipLogosAnimation;
  late final Animation<double> opacityLogos;
  late final Animation<double> opacityCircle;
  late final Animation<double> animationOuterCircle;
  late final Animation<double> animationInnerCircle;
  late final Animation<double> opacityPaws;
  late final Animation<Offset> animationPaws;
  late final Animation<double> animationPawsStreatch;
  late final Animation<bool> animationDodoVisible;
  late final Animation<double> animationDodoTranslate;
  late final Animation<double> irisAnimation;
  late final Animation<double> opacityProfileForm;
  late final Animation<double> animationFlipProfileForm;
  late final Animation<double> animationFlipProfile1;
  late final Animation<double> animationFlipProfile2;
  late final Animation<double> animationFlipProfile3;

  void initializeAnimations() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 7700),
      vsync: state,
    );
    opacityAnimationSmartXRLogo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.076075, curve: Curves.easeOut),
      ),
    );
    opacityAnimationKidsLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.076075, 0.076075, curve: Curves.easeOut),
      ),
    );
    rotateAnimationKidsLogo = Tween<double>(begin: 3.14, end: 6.28).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.076075, 0.1371, curve: Curves.bounceOut),
      ),
    );

    flipLogosAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2663, 0.2790, curve: Curves.easeOut),
      ),
    );
    opacityLogos = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2782, 0.2790, curve: Curves.easeOut),
      ),
    );
    opacityCircle = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2782, 0.2790, curve: Curves.linear),
      ),
    );

    animationOuterCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1, end: 1.2), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1), weight: 2),
      // TweenSequenceItem(tween: Tween(begin: 50.h, end: 100.h), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 17), weight: 2),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2790, 0.4, curve: Curves.easeIn),
      ),
    );
    animationInnerCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.h, end: 0.h), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 380.h), weight: 100),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 0.45, curve: Curves.easeIn),
      ),
    );
    opacityPaws = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.45, 0.45, curve: Curves.linear),
      ),
    );
    animationPaws = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 390.h), end: Offset(0, 320.h)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 320.h), end: Offset(0, 390.h)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.45, 0.48, curve: Curves.easeIn),
      ),
    );
    animationPawsStreatch = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 20), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.48, 0.55, curve: Curves.easeInOut),
      ),
    );
    animationDodoVisible = Tween<bool>(begin: false, end: true).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.55, 0.55, curve: Curves.linear),
      ),
    );
    animationDodoTranslate = Tween<double>(begin: 220, end: 15).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.55, 0.58, curve: Curves.linear),
      ),
    );

    irisAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.9, 0.93, curve: Curves.linear),
      ),
    );
    opacityProfileForm = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.93, 0.93, curve: Curves.linear),
      ),
    );
    animationFlipProfileForm = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.93, 1, curve: Curves.easeInOut),
      ),
    );
    animationFlipProfile1 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.93, 0.95, curve: Curves.easeInOut),
      ),
    );
    animationFlipProfile2 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.95, 0.97, curve: Curves.easeInOut),
      ),
    );
    animationFlipProfile3 = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1, end: 2.5), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 2.5, end: 1), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.97, 1, curve: Curves.easeInOut),
      ),
    );
    controller.forward();
    // controller.addListener(() {
    //   state.setState(() {});
    // });
  }

  void dispose() {
    controller.dispose();
  }
}
