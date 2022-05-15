import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:siap_baper/controllers/request_controller.dart';
import 'package:siap_baper/widgets/homepage/menu_widget.dart';

import '../constant.dart';
import '../controllers/local_storage_controller.dart';
import '../controllers/login_controller.dart';
import '../models/request_model.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final LocalStorageController localStorageController = Get.find(tag: 'localStorageController');
  final RequestController requestController = Get.find(tag: 'requestController');
  final LoginController loginController = Get.find(tag: 'loginController');

  @override
  Widget build(BuildContext context) {
    if (localStorageController.isLogin) {
      requestController.fetchHistoryRequest();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (loginController.profile.value.role == 'ADMIN') {
            Get.snackbar(
              'Opss',
              'Role Admin tidak bisa melakukan pengajuan persediaan',
              duration: const Duration(milliseconds: 3000),
              backgroundColor: Colors.red.withOpacity(1),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.clear),
              shouldIconPulse: true,
            );
          } else {
            if (localStorageController.isLogin) {
              Get.toNamed('/permintaan');
            } else {
              Get.snackbar(
                'Opss',
                'Login terlebih dahulu',
                duration: const Duration(milliseconds: 3000),
                backgroundColor: Colors.red.withOpacity(0.7),
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(Icons.clear),
                shouldIconPulse: true,
              );
            }
          }
        },
        // backgroundColor: kSecondary,
        icon: Icon(
          Icons.add,
          color: Colors.black,
          size: 14,
        ),
        backgroundColor: Colors.white,
        label: Text(
          'Pengajuan',
          style: kBlackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: kPadding, right: kPadding),
              child: SimpleBuilder(builder: (context) {
                if (localStorageController.isLogin) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "${loginController.profile.value.name}",
                            style: kWhiteFontStyle.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Selamat datang kembali",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Color(0xffa29aac),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                      // Stack(
                      //   children: [
                      //     Icon(
                      //       FontAwesomeIcons.bell,
                      //       size: 24,
                      //       color: Colors.white,
                      //     ),
                      //     _redDot()
                      //   ],
                      // ),
                    ],
                  );
                } else {
                  return Row(
                    children: [
                      Text(
                        'Log in untuk memulai',
                        style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  );
                }
              }),
            ),
            GetBuilder<RequestController>(
                id: 'fetchHistory',
                init: requestController,
                builder: (ctx) {
                  if (requestController.isLoading.value) {
                    return Container(
                      margin: EdgeInsets.only(
                        top: 20,
                      ),
                      child: const Center(
                        child: SpinKitWave(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    if (localStorageController.isLogin &&
                        requestController.requestHistoryList.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 15, bottom: 5),
                            padding: EdgeInsets.symmetric(horizontal: kPadding),
                            child: Text(
                              'Pengajuan Terakhir',
                              style: kWhiteFontStyle.copyWith(
                                fontSize: 16,
                              ),
                            ),
                            height: 30,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            width: double.infinity,
                            height: 120,
                            child: Obx(() {
                              return ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: requestController.requestHistoryList.length > 5
                                      ? 5
                                      : requestController.requestHistoryList.length,
                                  itemBuilder: (context, index) {
                                    RequestData data = requestController.requestHistoryList[index];
                                    return SizedBox(
                                      width: 200,
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/detail-ticket',
                                              arguments: {'noTicket': data.noTicket});
                                        },
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: Container(
                                                margin: EdgeInsets.only(right: 10, left: 10),
                                                padding: EdgeInsets.symmetric(horizontal: kPadding),
                                                height: 100,
                                                width: 190,
                                                decoration: BoxDecoration(
                                                  color: kSecondary,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      data.noTicket!,
                                                      style: kWhiteFontStyle.copyWith(fontSize: 18),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(DateFormat.yMMMd().format(data.createdAt!),
                                                        style: kWhiteFontStyle),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 10,
                                              child: Container(
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: data.status == 'PENDING'
                                                      ? Colors.orange
                                                      : data.status == 'ACCEPT'
                                                          ? Colors.green
                                                          : Colors.red,
                                                  borderRadius: const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                ),
                                                child: Text(
                                                  data.status!,
                                                  style: kBlackFontStyle,
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  }
                }),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 15, bottom: 5),
              padding: EdgeInsets.symmetric(horizontal: kPadding),
              child: Text(
                'Menu',
                style: kWhiteFontStyle.copyWith(
                  fontSize: 16,
                ),
              ),
              height: 30,
            ),
            MenuWidget()
          ],
        ),
      ),
    );
  }

  Widget _redDot() {
    return Positioned(
      right: 0,
      top: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(7),
        ),
        constraints: const BoxConstraints(
          minWidth: 10,
          minHeight: 10,
        ),
        child: const SizedBox(
          width: 1,
          height: 1,
        ),
      ),
    );
  }
}
