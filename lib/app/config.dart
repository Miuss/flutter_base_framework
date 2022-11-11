
///
/// 项目基础配置
///

class Config {
  static const bool inProduction = bool.fromEnvironment("dart.vm.product");
  static const String baseUrl = 'http://localhost/api/base'; //请求api
  static const String contentType = 'application/json; charset=utf-8';
  static const int requestTimeout = 100000000;
  static const List<int> successCode = [200, 0];
  static const String statusName = 'code';
  static const String messageName = 'message';
}
