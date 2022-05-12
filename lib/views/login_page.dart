import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siap_baper/constant.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final LoginController loginController = Get.find(tag: 'loginController');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SingleChildScrollView(
        child: Obx(() {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: Get.height * 0.5,
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_login.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: kPadding,
                  ),
                  child: Text(
                    "NIP",
                    style: kWhiteFontStyle.copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: kPadding),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: kPadding),
                        child: const Icon(
                          Icons.person_outline,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.5),
                        margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                      ),
                      Expanded(
                        child: TextField(
                          enabled: !loginController.isLoading.value,
                          controller: loginController.nipController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nomor Induk Pegawai',
                            hintStyle: kWhiteFontStyle2.copyWith(fontSize: 14),
                          ),
                          style: kWhiteFontStyle2.copyWith(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: kPadding),
                  child: Text(
                    "Password",
                    style: kWhiteFontStyle.copyWith(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: kPadding),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: kPadding),
                        child: const Icon(
                          Icons.lock_open,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        height: 30.0,
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.5),
                        margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                      ),
                      Expanded(
                        child: TextField(
                          enabled: !loginController.isLoading.value,
                          obscureText: !loginController.passwordVisible.value,
                          controller: loginController.passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                loginController.passwordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                loginController.passwordVisible.value =
                                    !loginController.passwordVisible.value;
                              },
                            ),
                            border: InputBorder.none,
                            hintText: 'Masukan password',
                            hintStyle: kWhiteFontStyle2.copyWith(fontSize: 14),
                          ),
                          style: kWhiteFontStyle2.copyWith(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: kPadding),
                  padding: EdgeInsets.only(left: kPadding, right: kPadding),
                  child: RoundedLoadingButton(
                    successColor: Colors.white,
                    valueColor: kPrimary,
                    color: Colors.white,
                    borderRadius: 10,
                    child: Text(
                      'Sign in',
                      style: kBlackFontStyle.copyWith(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    controller: loginController.btnController,
                    onPressed: () async {
                      bool success = await loginController.authLogin();
                      if (success) {
                        loginController.btnController.success();
                        await Future.delayed(const Duration(milliseconds: 400),
                            () {
                          Get.offNamed(
                            '/',
                          );
                          loginController.nipController.clear();
                          loginController.passwordController.clear();
                        });
                      } else {
                        Get.snackbar(
                          'Error',
                          'NIP dan Password salah',
                          backgroundColor: Colors.red.withOpacity(0.4),
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(Icons.alarm),
                          shouldIconPulse: true,
                        );
                        await Future.delayed(const Duration(milliseconds: 400),
                            () {
                          loginController.btnController.reset();
                        });
                      }
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: kPadding, bottom: 80),
                  padding: EdgeInsets.only(left: kPadding, right: kPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Belum punya akun ?',
                        style: kWhiteFontStyle.copyWith(
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        ' Hubungi Sub Seksi Keuangan dan Perlengkapan',
                        style: kWhiteFontStyle2.copyWith(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.85);
    p.arcToPoint(
      Offset(0.0, size.height * 0.85),
      radius: const Radius.elliptical(50.0, 10.0),
      rotation: 0.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
