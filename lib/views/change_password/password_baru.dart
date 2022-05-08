import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siap_baper/controllers/login_controller.dart';

import '../../constant.dart';

class PasswordBaru extends StatelessWidget {
  PasswordBaru({Key? key}) : super(key: key);
  LoginController loginController = Get.find(tag: 'loginController');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SizedBox(
        height: Get.height,
        child: Center(
          child: Container(
            height: 400,
            padding: EdgeInsets.all(
              kPadding,
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    ' Password Baru',
                    style: kWhiteFontStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    controller: loginController.passwordBaruController,
                    style: kWhiteFontStyle.copyWith(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 28, color: Colors.white60),
                      hintText: "Ketik disini",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Obx(() {
                  if (loginController.isPasswordBaruFill.value) {
                    return Container(
                      constraints: BoxConstraints(maxWidth: 300, maxHeight: 50.0),
                      margin: EdgeInsets.all(10),
                      child: RoundedLoadingButton(
                        successColor: Colors.white,
                        borderRadius: 10,
                        valueColor: kPrimary,
                        color: Colors.white,
                        child: Text(
                          'Submit',
                          style:
                              kBlackFontStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        controller: loginController.btnChangePasswordController,
                        onPressed: () async {
                          bool success = await loginController.changePassword();
                          if (success) {
                            loginController.btnChangePasswordController.success();
                            await Future.delayed(const Duration(milliseconds: 400), () {
                              Get.offAllNamed('/');
                              Get.snackbar(
                                'Success',
                                'Password berhasil di ubah',
                                backgroundColor: Colors.green,
                                snackPosition: SnackPosition.BOTTOM,
                                icon: const Icon(Icons.check),
                                shouldIconPulse: true,
                              );
                            });
                          } else {
                            loginController.btnChangePasswordController.error();
                            Get.offAllNamed('/');
                            Get.snackbar(
                              'Error',
                              'Password lama tidak sesuai.',
                              backgroundColor: Colors.red.withOpacity(0.8),
                              snackPosition: SnackPosition.BOTTOM,
                              icon: const Icon(Icons.alarm),
                              shouldIconPulse: true,
                            );
                          }
                          await Future.delayed(const Duration(milliseconds: 500), () {
                            loginController.btnChangePasswordController.reset();
                          });
                        },
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
