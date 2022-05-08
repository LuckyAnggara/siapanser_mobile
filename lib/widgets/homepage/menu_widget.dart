import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant.dart';
import '../../controllers/local_storage_controller.dart';
import '../../controllers/login_controller.dart';

class MenuWidget extends StatelessWidget {
  final LocalStorageController localStorageController = Get.find(tag: 'localStorageController');
  final LoginController loginController = Get.find(tag: 'loginController');

  List<Menu> menuData = [
    Menu(
        title: 'Persediaan',
        subtitle: 'Lihat data persediaan',
        route: "/product",
        img: 'assets/icon/persediaan.png'),
    Menu(
        title: 'History',
        subtitle: 'Lihat history pengajuan',
        route: "/history",
        img: 'assets/icon/history.png'),
    Menu(
        title: 'Profile',
        subtitle: 'Lihat profile kamu',
        route: "/profile",
        img: 'assets/icon/profile.png'),
    // Menu(
    //     title: 'Qr Code',
    //     subtitle: 'Scan pengajuan dengan QR Code',
    //     route: "/qrcode",
    //     img: 'assets/icon/qrcode.png'),
    Menu(
        title: 'Logout',
        subtitle: 'Logout account dari aplikasi',
        route: "/logout",
        img: 'assets/icon/logout.png'),
    Menu(
        title: 'Login',
        subtitle: 'Masuk untuk akses lebih luas',
        route: "/login",
        img: 'assets/icon/login.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SimpleBuilder(builder: (context) {
      return Flexible(
        child: GridView.count(
            physics: const BouncingScrollPhysics(),
            childAspectRatio: 1.0,
            padding: EdgeInsets.only(left: kPadding, right: kPadding),
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            children: menuData.where((e) {
              if (e.route == '/logout') {
                if (localStorageController.isLogin) {
                  return true;
                } else {
                  return false;
                }
              } else if (e.route == '/login') {
                if (localStorageController.isLogin) {
                  return false;
                } else {
                  return true;
                }
              } else if (e.route == '/profile') {
                if (localStorageController.isLogin) {
                  return true;
                } else {
                  return false;
                }
              } else if (e.route == '/history') {
                if (localStorageController.isLogin) {
                  return true;
                } else {
                  return false;
                }
              } else {
                return true;
              }
            }).map((data) {
              return GestureDetector(
                onTap: () {
                  if (data.route == '/logout') {
                    Get.defaultDialog(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: kPadding,
                          vertical: 10,
                        ),
                        buttonColor: kSecondary,
                        title: 'Confirmation',
                        titleStyle: kWhiteFontStyle,
                        middleTextStyle: kWhiteFontStyle.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                        confirmTextColor: Colors.red,
                        textConfirm: 'Logout',
                        textCancel: 'Cancel',
                        backgroundColor: kPrimary,
                        middleText: 'Anda yakin akan logout ?',
                        onConfirm: () async {
                          loginController.logout();
                          Get.back();
                          Get.snackbar(
                            'Logout!',
                            'Anda berhasil logout',
                            backgroundColor: Colors.green,
                            snackPosition: SnackPosition.TOP,
                            icon: const Icon(Icons.check),
                            shouldIconPulse: true,
                          );
                        });
                  } else {
                    Get.toNamed(data.route);
                  }
                },
                child: Container(
                  decoration:
                      BoxDecoration(color: kSecondary, borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        data.img,
                        width: 42,
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(data.title, style: kWhiteFontStyle),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          data.subtitle,
                          style: kWhiteFontStyle2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                    ],
                  ),
                ),
              );
            }).toList()),
      );
    });
  }
}
