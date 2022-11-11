import '../../app/data/api/account.dart';
import '../../app/data/api/auth.dart';
import '../../app/routes/app_pages.dart';
import '../../app/store/store_service.dart';
import '../../app/utils/request.dart';
import '../../app/widgets/toast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

/// 检查登录状态
checkLoginStatus() async {
  String token =
      GetStorage().hasData('token') ? GetStorage().read('token') : '';

  if (token == '') {
    // Token不存在返回到用户主页
    return Get.offAllNamed(AppRoutes.initial);
  }

  setSessionToken(token);

  var res = await getAccountInfo();
  store_service()
      .store
      .userInfo
      .addAll(Map<String, dynamic>.from({...res['data']}));

  return Get.offAllNamed(AppRoutes.home);
}

updateUserInfo() async {
  var res = await getAccountInfo();
  store_service()
      .store
      .userInfo
      .addAll(Map<String, dynamic>.from({...res['data']}));
}

/// 清除本地数据及位置监听
clearStoreData() async {
  print('清除本地数据及位置监听');
  clearStore();
  clearSessionToken();
  Get.offAllNamed(AppRoutes.initial);
}

/// 用户登出
logout() async {
  await logoutAccount();
  clearStoreData();
  Get.offAllNamed(AppRoutes.initial);
}

/// 验证是否是手机号
bool isChinaPhoneLegal(String str) {
  return RegExp(
          '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
      .hasMatch(str);
}