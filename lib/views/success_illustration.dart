import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:siap_baper/constant.dart';

import '../controllers/permintaan_controller.dart';

class SuccessIllustration extends StatelessWidget {
  final PermintaanController permintaanController = Get.find(tag: 'permintaan_controller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Stack(
        children: [
          Obx(() {
            if (permintaanController.isLoading.value) {
              return const Center(
                child: SpinKitPouringHourGlassRefined(
                  color: Colors.black,
                ),
              );
            } else {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icon/icon-success.png',
                    scale: 0.8,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sukses',
                    style: kWhiteFontStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Permintaan mu berhasil di kirim',
                    style: kWhiteFontStyle2.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  // Container(
                  //   constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  //   margin: EdgeInsets.all(10),
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Get.offAllNamed('/detail-ticket', arguments: {'noTicket': data.noTicket});
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //         primary: Colors.white,
                  //         padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                  //         textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  //     child: Padding(
                  //       padding: EdgeInsets.all(0),
                  //       child: Container(
                  //         alignment: Alignment.center,
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: <Widget>[
                  //             Center(
                  //               child: Text(
                  //                 'Lihat detail pengajuan',
                  //                 style: kBlackFontStyle.copyWith(
                  //                     fontSize: 15, fontWeight: FontWeight.w500),
                  //               ),
                  //             ),
                  //             Icon(
                  //               Icons.arrow_forward,
                  //               color: Colors.black,
                  //             )
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ));
            }
          }),
          Positioned(
            right: 10,
            top: 30,
            child: SizedBox(
              height: 50,
              width: 50,
              child: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  Get.offAllNamed('/');
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
