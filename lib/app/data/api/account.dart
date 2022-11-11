import '../../utils/request.dart';

///
/// 获取用户信息
///

dynamic getAccountInfo() async {
  return await Axios.request.get('/userinfo/get-accountinfo');
}

///
/// 更新用户信息
///
dynamic updateAccountInfo(String nickName, String avatar) async {
  return await Axios.request
      .post('/userinfo/save', {'nickName': nickName, 'avatar': avatar});
}

///
/// 校验当前手机号
///
dynamic checkAccountPhoneNumber(String phoneNumber, String code) async {
  return await Axios.request
      .get('/userinfo/check-phonenumber/$phoneNumber/$code');
}

///
/// 绑定手机号
///
dynamic changePhoneNumber(String phoneNumber, String code) async {
  return await Axios.request
      .post('/userinfo/bind-new-phonenumber/$phoneNumber/$code', null);
}
