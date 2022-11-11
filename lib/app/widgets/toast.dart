import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void easyToast(String text, {bool? isShort = false, bool? isLong = false}) {
  EasyLoading.instance
    ..displayDuration = isLong == true
        ? const Duration(milliseconds: 3000)
        : (isShort == true
            ? const Duration(milliseconds: 1000)
            : const Duration(milliseconds: 2000))
    ..loadingStyle = EasyLoadingStyle.custom // loading的样式
    ..boxShadow = <BoxShadow>[]
    ..backgroundColor = const Color.fromARGB(191, 0, 0, 0) // loading自定义样式
    ..indicatorColor = Colors.white // loading自定义样式
    ..textColor = Colors.white // loading自定义样式
    ..dismissOnTap = false // 是否可点击关闭
    ..maskColor = Colors.transparent; // 背景颜色
  EasyLoading.showToast(text,
      toastPosition: EasyLoadingToastPosition.center,
      maskType: EasyLoadingMaskType.custom);
}
