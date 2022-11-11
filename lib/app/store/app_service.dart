import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../app/store/store_service.dart';

initServices() async {
  //先将service放入系统
  //执行init方法
  await GetStorage.init();
  await Get.put(storageService());
  await Get.put(storeService());
}

// storage: token isFirstIn
storageService storage_service() {
  return Get.find<storageService>();
}

class storageService extends GetxService {
  Future<void> onInit() async {
    //此方法会在加载第一个页面之前运行
    super.onInit();
  }

  // void clearStorage(){
  //   GetStorage().erase();
  // }
}
