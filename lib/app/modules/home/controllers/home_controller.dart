import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fstack_rider/core/picture/picture_img.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {

  RxDouble latitude = 20.99213800591695.obs;
  RxDouble longitude = 105.81020471504765.obs;
  late StreamSubscription<Position> streamSubscription;
  late BitmapDescriptor iconRider;
  late BitmapDescriptor iconCenter;
  int idex =0;
  //RxList<Repair> list = RxList([]);
  late GoogleMapController mapController;
  final Completer<GoogleMapController> controllerMap = Completer();
  RxList<Marker> allMarkers = RxList([]);
  RxBool checkSwitch  = true.obs;

  @override
  void onInit() async {
    super.onInit();
    await loadIconRider();
    await loadIconCenter();
    await getLocation();
  }
  getLocation() async {
    streamSubscription =
        Geolocator.getPositionStream().listen((Position position) {
          Marker marker = allMarkers.firstWhere((marker) => marker.markerId.value == "Test3");
          allMarkers.remove(marker);
          addMarker('Test3', LatLng(position.latitude, position.longitude));
          latitude.value = position.latitude;
          longitude.value = position.longitude;
        });
  }
  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(20.984518951804887, 105.79855556245529),
    zoom: 16,
  );
  addMarker(String id, LatLng location) {
    var maker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: const InfoWindow(
            title: "Vị trí của bạn",
            snippet: "Bạn có tìm kiếm các thợ xung quanh"),
        icon: iconRider
    );
    allMarkers.add(maker);
  }
  addMarkerCenter() {
    var maker = Marker(
        markerId: const MarkerId("Test1"),// 20.984518951804887, 105.79855556245529
        position: indexMap(20.984518951804887, 105.79855556245529),
        infoWindow:  const InfoWindow(
            title: "Trung tâm điều phối",
            snippet: "Làm việc uy tín nhanh nhẹ"),
        icon: iconCenter,
    );
    allMarkers.add(maker);
  }
  indexMap(double x, double y) {
    LatLng current = LatLng(x, y);
    return current;
  }
  Future<void> loadIconRider() async {
    iconRider = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(49, 49)),
        riderfs);
    // return icons;
  }
  Future<void> loadIconCenter() async {
    iconCenter  = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(49, 49)),
        centerFs);
    // return icons;
  }

}
