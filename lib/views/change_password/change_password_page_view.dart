import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/controllers/login_controller.dart';
import 'package:siap_baper/views/change_password/password_baru.dart';
import 'package:siap_baper/views/change_password/password_lama.dart';

class ChangePasswordPageView extends StatelessWidget {
  ChangePasswordPageView({Key? key}) : super(key: key);
  LoginController loginController = Get.find(tag: 'loginController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: loginController.changePasswordPageController.value,
        children: [
          PasswordLama(),
          PasswordBaru(),
        ],
      ),
    );
  }
}
