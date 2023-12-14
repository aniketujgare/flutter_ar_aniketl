import 'package:flutter/animation.dart';
import 'package:size_config/size_config.dart';

import '../../../presentation/login/pages/login_screen.dart';

class LoginScreenAnimationController {
  final LoginScreenState state;
  LoginScreenAnimationController(this.state);

  late final AnimationController controller;
  late final Animation<double> sizeAnimationSmartXRLogo;
  late final Animation<double> opacityAnimationSmartXRLogo;
  late final Animation<double> rotateAnimationKidsLogo;
  late final Animation<double> opacityAnimationKidsLogo;
  late final Animation<double> flipLogosAnimation;
  late final Animation<double> opacityLogos;
  late final Animation<double> opacityCircle;
  late final Animation<double> animationCircle;
  late final Animation<double> opacityPaws;
  late final Animation<Offset> animationPaws;
  late final Animation<double> animationPawsStreatch;
  late final Animation<bool> animationDodoVisible;
  late final Animation<double> animationDodoTranslate;
  late final Animation<double> opacityLoginForm;

  void initializeAnimations() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 5900),
      vsync: state,
    );

    sizeAnimationSmartXRLogo = Tween<double>(
      begin: 0.7,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.17, curve: Curves.easeOut),
      ),
    );
    opacityAnimationSmartXRLogo = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.17, curve: Curves.easeOut),
      ),
    );
    rotateAnimationKidsLogo = Tween<double>(begin: 3.14, end: 6.28).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.17, 0.31, curve: Curves.bounceOut),
      ),
    );
    opacityAnimationKidsLogo = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.17, 0.31, curve: Curves.easeOut),
      ),
    );

    flipLogosAnimation = Tween<double>(
      begin: 0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.306, 0.34, curve: Curves.easeOut),
      ),
    );
    opacityLogos = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.33, 0.34, curve: Curves.easeOut),
      ),
    );
    opacityCircle = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.35, 0.386, curve: Curves.linear),
      ),
    );

    animationCircle = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 60.h), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 60.h, end: 50.h), weight: 2),
      // TweenSequenceItem(tween: Tween(begin: 50.h, end: 100.h), weight: 3),
      TweenSequenceItem(tween: Tween(begin: 50.h, end: 1400.h), weight: 2),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.386, 0.483, curve: Curves.easeIn),
      ),
    );

    opacityPaws = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.483, 0.483, curve: Curves.linear),
      ),
    );
    animationPaws = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 0.h), end: Offset(0, 190.h)),
          weight: 1),
      TweenSequenceItem(
          tween: Tween(begin: Offset(0, 190.h), end: Offset(0, 0.h)),
          weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.483, 0.55, curve: Curves.easeIn),
      ),
    );
    animationPawsStreatch = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 20), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 20, end: 0), weight: 1),
    ]).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 0.58, curve: Curves.easeInOut),
      ),
    );
    animationDodoVisible = Tween<bool>(begin: false, end: true).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.58, 0.58, curve: Curves.linear),
      ),
    );
    animationDodoTranslate = Tween<double>(begin: 220, end: -40).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.58, 0.64, curve: Curves.linear),
      ),
    );
    opacityLoginForm = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.64, 0.8, curve: Curves.linear),
      ),
    );
    /////////////////////////////
    ///
    controller.forward();
  }

  void dispose() {
    controller.dispose();
  }
}
