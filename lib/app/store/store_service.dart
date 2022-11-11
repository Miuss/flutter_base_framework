import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

storeService store_service() {
  return Get.find<storeService>();
}

class storeService extends GetxService {
  late Store store = Store();
}

// store
class Store {
  final userInfo = <String, dynamic>{}.obs;

  /// 用户信息
  final netWork = true.obs;

  /// 网络是否可用
  final tabIndex = 0.obs;

  /// bottomBar切换索引
  final locationResult = {}.obs;

  /// 定位结果
  final showBottom = true.obs;

  /// 是否显示底部
  final colorList = [].obs;

  /// 颜色列表
}

clearStore() {
  store_service().store.userInfo.clear();
  store_service().store.userInfo.addAll(Map<String, dynamic>.from({}.obs));
  store_service().store.tabIndex.value = 0;
  store_service().store.showBottom.value = true;
  store_service().store.locationResult.addAll({
    'latitude': 31.24916171,
    'longitude': 121.487899486,
    'speed': 0.0,
    'bearing': 0.0
  });
}
