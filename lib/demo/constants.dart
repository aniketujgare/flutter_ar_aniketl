import 'package:flutter/material.dart';

bool isMobile(BuildContext context) {
  // Landscape Mode
  var height = MediaQuery.of(context).size.height;
  return height < 500;
}
