import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:flutter_base_framework/app/themes/app_colors.dart';
import 'package:flutter_base_framework/app/themes/app_text_theme.dart';

class Common {
  Common._();

  static void dismissKeyboard() => Get.focusScope!.unfocus();
}
