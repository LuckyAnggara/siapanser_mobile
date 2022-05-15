import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:siap_baper/views/Permintaan/Notes.dart';
import 'package:siap_baper/views/Permintaan/permintaan_page_view.dart';
import 'package:siap_baper/views/change_password/change_password_page_view.dart';
import 'package:siap_baper/views/detail_page.dart';
import 'package:siap_baper/views/history_page.dart';
import 'package:siap_baper/views/home_page.dart';
import 'package:siap_baper/views/login_page.dart';
import 'package:siap_baper/views/permintaan_page.dart';
import 'package:siap_baper/views/product_page.dart';
import 'package:siap_baper/views/profile_page.dart';
import 'package:siap_baper/views/success_illustration.dart';

import 'controllers/local_storage_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/request_controller.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final LocalStorageController localStorageController =
        Get.put(LocalStorageController(), tag: 'localStorageController');
    final RequestController requestController =
        Get.put(RequestController(), tag: 'requestController');
    final LoginController loginController = Get.put(LoginController(), tag: 'loginController');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => HomePage(), transition: Transition.fadeIn),
        GetPage(
            name: '/login',
            page: () {
              if (localStorageController.isLogin) {
                return HomePage();
              } else {
                return LoginPage();
              }
            }),
        GetPage(name: '/product', page: () => ProductPage(), transition: Transition.cupertino),
        GetPage(name: '/profile', page: () => ProfilePage(), transition: Transition.cupertino),
        GetPage(
            name: '/change-password',
            page: () => ChangePasswordPageView(),
            transition: Transition.topLevel),
        GetPage(name: '/permintaan', page: () => PermintaanPage(), transition: Transition.downToUp),
        GetPage(name: '/history', page: () => HistoryPage(), transition: Transition.downToUp),
        GetPage(
            name: '/detail-ticket', page: () => DetailPage(), transition: Transition.rightToLeft),
        GetPage(
            name: '/tambah-permintaan',
            page: () => PermintaanPageView(),
            transition: Transition.cupertino),
        GetPage(name: '/tambah-permintaan/notes', page: () => Notes(), transition: Transition.size),
        GetPage(
            name: '/success-illustration',
            page: () => SuccessIllustration(),
            transition: Transition.fadeIn),
      ],
      // theme: ThemeData(
      //   textTheme: GoogleFonts.robotoTextTheme(),
      // ),
    );
  }
}
