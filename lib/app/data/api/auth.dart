import '../../utils/request.dart';

///
/// 发送手机登录注册验证码
///
dynamic sendPhoneVerifyCode(String phoneNumber) async {
  return await Axios.request.get('/account/send-verifcode/$phoneNumber');
}

///
/// 手机验证码登陆
///
dynamic verifyPhoneCodeLogin(String phoneNumber, String code) async {
  return await Axios.request.post('/account/check-phonenumber-code-login',
      {'phoneNumber': phoneNumber, 'code': code});
}

///
/// 登出
///
dynamic logoutAccount() async {
  return await Axios.request.get('/userinfo/loginout');
}
