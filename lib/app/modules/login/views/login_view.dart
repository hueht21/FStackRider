import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fstack_rider/core/utils/utils.dart';

import 'package:get/get.dart';

import '../../../../core/picture/picture_svg.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white54,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SizedBox(
          width: totalWidth,
          height: totalHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: totalWidth * 0.3,
              ),
              SizedBox(
                width: totalWidth * 0.375,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 14,
                        ),
                        Text("Đăng nhập", style: FontUtils.font26W700(), ),
                      ],
                    ),
                     Padding(
                      padding: const EdgeInsets.only(left: 14, top: 6),
                      child: Container(
                        height: 5,
                        color: const Color(0xff6B46D6),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 14),
                child: Text("Đăng nhập để hoàn thành nhiệm vụ của mình", style: FontUtils.font16W700(),),
              ),
              const SizedBox(
                height: 19,
              ),
              _inputValue(himText: "Email", icon: iconUser),
              const SizedBox(
                height: 14,
              ),
              _inputValue(himText: "Mật khẩu", icon: iconPass),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: Text("Quên mật khẩu", style: FontUtils.font14W700(),),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              SizedBox(
                width: totalWidth,
                height: 46,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14,right: 14),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff6B46D6)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),)
                          )
                      ),
                      onPressed: () {
                        Get.offNamed("/home");

                      },
                      child: Text("Đăng nhập", style: FontUtils.font16W600(),)),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  Widget _inputValue({required String himText, required String icon}) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, right: 14),
      child: Container(
        height:50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              width: 15,
            ),
            SizedBox(
                width: 24,
                height : 24,
                child: SvgPicture.asset(icon)),
            const SizedBox(width: 25,),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: himText,
                    hintStyle: FontUtils.font14W500()

                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
