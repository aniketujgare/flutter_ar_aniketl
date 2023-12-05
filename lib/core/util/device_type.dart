import 'package:flutter/widgets.dart';

class DeviceType {
  static DeviceType? _instance;
  late bool _isMobile;

  factory DeviceType() {
    _instance ??= DeviceType._();
    return _instance!;
  }

  DeviceType._() {
    // Calculate the device type during initialization
    _isMobile = _calculateIsMobile();
  }

  bool get isMobile => _isMobile;

  bool _calculateIsMobile() {
    // You can customize the logic to determine whether the device is a tablet or not
    // For example, by checking the screen size or other device-specific characteristics
    return MediaQueryData.fromView(
                WidgetsBinding.instance.platformDispatcher.views.single)
            .size
            .shortestSide <=
        600;
  }
}
