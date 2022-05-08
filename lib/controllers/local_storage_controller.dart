import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/auth_model.dart';

class LocalStorageController extends GetxController {
  final box = GetStorage();

  bool get isLogin => box.read('login') ?? false;
  String? get getToken => box.read('token');

  void setLogin(bool val) => box.write('login', val);

  void setToken(Token token) {
    box.write('token', "${token.tokenType} ${token.accessToken}");
  }

  void destroyToken() {
    box.remove('token');
  }

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
    Menu(
        title: 'Qr Code',
        subtitle: 'Scan pengajuan dengan QR Code',
        route: "/qrcode",
        img: 'assets/icon/qrcode.png'),
  ];
}

class Menu {
  String title;
  String subtitle;
  String route;
  String img;

  Menu({required this.title, required this.subtitle, required this.route, required this.img});
}
