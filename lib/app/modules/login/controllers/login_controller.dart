import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  final count = 0.obs;
  @override
  void onInit() async {
    super.onInit();
    await getLocation();
  }
  getLocation() async
  {
    bool serviceEnable;
    LocationPermission permission;
    serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      await Geolocator.openLocationSettings();
      return Future.error("Location service are disable");
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error("Location service are disable");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location service are disable");
    }
  }
}
