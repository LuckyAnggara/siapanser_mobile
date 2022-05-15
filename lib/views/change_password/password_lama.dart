import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/controllers/login_controller.dart';

import '../../constant.dart';

class PasswordLama extends StatelessWidget {
  PasswordLama({Key? key}) : super(key: key);
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
                    ' Password Lama',
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
                    controller: loginController.passwordLamaController,
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
                  if (loginController.isPasswordLamaFill.value) {
                    return Container(
                      constraints: const BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          loginController.changePasswordNextPage();
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                            textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    'Lanjut',
                                    style: kBlackFontStyle.copyWith(
                                        fontSize: 15, fontWeight: FontWeight.w500),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
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
