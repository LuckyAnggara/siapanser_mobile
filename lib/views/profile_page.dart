import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/constant.dart';

import '../controllers/login_controller.dart';

class ProfilePage extends StatelessWidget {
  LoginController loginController = Get.find(tag: 'loginController');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.4,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  painter: HeaderCurvedContainer(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          fontSize: 35,
                          letterSpacing: 1.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white, width: 5),
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 2,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage('assets/images/avatar.png'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: Text(
                  loginController.profile.value.name!,
                  style: kBlackFontStyle.copyWith(
                    fontSize: 24,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                child: Text(
                  loginController.profile.value.nip!,
                  style: kBlackFontStyle.copyWith(
                    fontSize: 24,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Container(
                constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/change-password');
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                      textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          'Ganti Password',
                          style:
                              kWhiteFontStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  loginController.logout();
                  Get.offAllNamed('/');
                },
                style: TextButton.styleFrom(
                    foregroundColor: kPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                    textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Text(
                        'Logout',
                        style: kBlackFontStyle.copyWith(
                            fontSize: 14, color: kPrimary, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ))
        ],
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = kPrimary;
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
