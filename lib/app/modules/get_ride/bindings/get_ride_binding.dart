import 'package:get/get.dart';

import '../controllers/get_ride_controller.dart';

class GetRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetRideController>(
      () => GetRideController(),
    );
  }
}
