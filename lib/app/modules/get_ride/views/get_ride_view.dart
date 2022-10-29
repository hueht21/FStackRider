import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fstack_rider/core/picture/picture_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/utils.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/get_ride_controller.dart';

class GetRideView extends GetView<GetRideController> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text("Thông tin nhập chuyến", style: FontUtils.font14W500()),
        centerTitle: true,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white54,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: totalHeight * 0.6,
                  child: Obx(()
                  => GoogleMap(
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(homeController.allMarkers),
                    initialCameraPosition: homeController.kGooglePlex,
                    onMapCreated: (GoogleMapController ggController) {
                      homeController.controllerMap.complete(ggController);
                      homeController.addMarker(
                          "Test3",
                          homeController.indexMap(
                              homeController.latitude.value,
                              homeController.longitude.value)
                      );
                      Get.find<HomeController>().addMarkerCenter();
                    },
                  ),
                  ),
                ),
                Expanded(
                    child: Container(
                      height: totalWidth * 0.4,
                      width: totalWidth,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Nguyễn Thị Oanh", style: FontUtils.font16W700(),),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("0386742599", style: FontUtils.font14W500(),)
                                ],
                              ),
                              const Flexible(child: SizedBox(),fit: FlexFit.tight,),
                              _itemPhone(),
                              const SizedBox(
                                width: 15,
                              ),
                              _itemPhone(),
                              SizedBox(
                                width: totalWidth * 0.08,
                              )

                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),

          ),
        ),
      )
    );
  }
  Widget _itemPhone(){
    return                               Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffB6B6B6FF)),
      ),
      child: Center(child: SvgPicture.asset(usersvg)),
    );
  }
}
