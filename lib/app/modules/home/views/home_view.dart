import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fstack_rider/core/utils/utils.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/picture/picture_img.dart';
import '../../../../core/picture/picture_svg.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Text("Trạng thái" , style: FontUtils.font14W500(),),
              Obx(()
                => Switch(
                    value: controller.checkSwitch.value,
                    onChanged: (bool value) {
                  controller.checkSwitch.value = value;
                }),
              ),
              Obx(() => Text(controller.checkSwitch.value == true ? "Bật" : "Tắt" , style: FontUtils.font14W500(),)),
              SizedBox(width: totalWidth * 0.06,),
              optionCircle(width: 24, height: 24, icon: messengeruser),
              const SizedBox(width: 15,),
              InkWell(
                onTap: () {
                  Get.toNamed("/get-ride");
                },
                  child: optionCircle(width: 24, height: 24, icon: notification)),
              const SizedBox(width: 20,),

            ],
          )

        ],
        centerTitle: true,
      ),
      drawer: Drawer(

        child: ListView(
          children: [
             //
            // _viewDrawer(totalHeight)
            _viewDrawerImg(totalHeight,totalWidth)
          ],
        )
      ),
      body: SafeArea(
        child: SizedBox(
          width: totalWidth,
          height: totalHeight,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return GoogleMap(
                    mapType: MapType.normal,
                    markers: Set<Marker>.of(controller.allMarkers),
                    initialCameraPosition: Get.find<HomeController>().kGooglePlex,
                    onMapCreated: (GoogleMapController ggController) {
                      controller.controllerMap.complete(ggController);
                      controller.addMarker(
                          "Test3",
                          controller.indexMap(
                              controller.latitude.value,
                              controller.longitude.value)
                      );
                      controller.addMarkerCenter();
                    },
                  );
                })
              )

            ],
          ),
        ),
      )
    );
  }
  Widget _viewDrawer(double totalHeight) {
    return SizedBox(
      height: totalHeight * 0.3,
      child: DrawerHeader(
          decoration: const BoxDecoration(
              color: Color(0xff6DB2DE),
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), bottomLeft: Radius.circular(20))
          ),
          child: Column(
            children: [
              Text("Tài xế", style: FontUtils.font20W700(),),
              const SizedBox(
                height: 14,
              ),
              Center(
                child: Container(
                  width: 106,
                  height: 106,
                  child: Image.asset(useruser),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .center,
                children: [
                  Text("Phạm Anh Huế",
                    style: FontUtils.font20W700(),),
                  const SizedBox(
                    width: 5.3,
                  ),
                  SvgPicture.asset(editname)
                ],
              ),
              const SizedBox(height: 2,),
              Text("phamngochue127@gmail.com",
                style: FontUtils.font15W400(),)
            ],
          )
      ),
    );

  }

  //
  Widget _viewDrawerImg(double totalHeight, double totalWidth) {
    return SingleChildScrollView(
      child: Container(
          // height: totalHeight * 0.409,
          // width: totalWidth,
          child: Stack(
            children: [
              Positioned(
                  child: Image.asset(backgrouduser)),
              Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                      children: [
                        Text("Tài xế", style: FontUtils.font20W700(),),
                        const SizedBox(
                          height: 14,
                        ),
                        Center(
                          child: Container(
                            width: 106,
                            height: 106,
                            child: Image.asset(useruser),
                          ),
                        ),
                        const SizedBox(
                          height: 11,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: [
                            Text("Phạm Anh Huế",
                              style: FontUtils.font20W700(),),
                            const SizedBox(
                              width: 5.3,
                            ),
                            SvgPicture.asset(editname)
                          ],
                        ),
                        const SizedBox(height: 2,),
                        Text("phamngochue127@gmail.com",
                          style: FontUtils.font15W400(),)
                      ],
                    ),
                  ),

              ),
              Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: totalHeight * 0.34),
                    child: Center(
                        child: _panerOption(icon1: usersvg, name1 :"Thông tin cá nhân", icon2: payuser, name2: "Thanh toán")
                    ),
                  )
              ),
              Positioned(
                  child: Padding(
                    padding: EdgeInsets.only(top: totalHeight * 0.5),
                    child: Center(
                        child:  _panerOption(icon1: setting, name1 :"Cài đặt", icon2: help, name2: "Trợ giúp", icon4: logout, name4: "Đăng xuất")
                    ),
                  )
              ),
            ],
          )
      ),
    );

  }
  //

  Widget optionCircle({required double width, required double height,required String icon, int? check}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.09),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            color: Colors.orange,
            shape: BoxShape.circle
        ),
        child: CircleAvatar(
            backgroundColor: Colors.white,
            child: check ==1 ? SvgPicture.asset(icon,color: const Color(0xff6B46D6),) : SvgPicture.asset(icon)
        )
    );
  }
  Widget _panerOption({required String icon1,required String name1 ,required String icon2,required String name2,String? icon4,String? name4 }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width:  260,
        height: icon4 != null ? 172 : 112,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: (){
                  if(icon1 == usersvg){
                    Get.snackbar("Thông báo", "Vào trang quản lý thông tin");
                  }
                  else if(icon1 == setting){
                    Get.snackbar("Thông báo", "Vào trang Cài đjăt");
                  }
                },
                child: itemOption(icon: icon1, name: name1)),
            const Divider(
              color: Color(0xffF3F3F9),
            ),
            itemOption(icon: icon2 , name: name2),
            if(icon4 != null)
              const Divider(color: Color(0xffF3F3F9),),
            if(icon4 != null)
              InkWell(
                  onTap: (){
                    Get.snackbar("Thông báo", "Vào trang đăng xuất");
                    Get.offAllNamed("/login");
                  },
                  child: itemOption(icon: icon4 , name: name4!)),
          ],
        ),
      ),
    );
  }
  Widget itemOption({required String icon,required String name})
  {
    return Container(
      height: 40,
      child:Row(
        children: [
          const SizedBox(
            width: 18,
          ),
          SvgPicture.asset(icon, width: 20,
            height: 20,
            color: const Color(0xff574B78),),
          const SizedBox(
            width: 19,
          ),
          Text(
            name, style: FontUtils.font16W600().copyWith(color: const Color(0xff574B78)),),
          const Flexible(fit: FlexFit.tight, child: SizedBox()),
          SvgPicture.asset(nextuser),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }
}


////