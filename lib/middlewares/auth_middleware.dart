import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/controllers/login_controller.dart';

class AuthMiddleware extends GetMiddleware {
  final loginController = Get.find<LoginController>();

  @override
  Widget onPageBuilt(Widget page) {
    print('Widget ${page.toStringShort()} will be showed');
    return page;
  }

  @override
  void onPageDispose() {
    print('PageDisposed');
  }
}
