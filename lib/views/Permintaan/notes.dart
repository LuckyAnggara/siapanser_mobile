import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siap_baper/controllers/permintaan_controller.dart';

import '../../constant.dart';

class Notes extends StatelessWidget {
  Notes({Key? key}) : super(key: key);
  final PermintaanController permintaanController = Get.find(tag: 'permintaan_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: SizedBox(
        height: Get.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(),
            Container(
              height: Get.height * 0.85,
              padding: EdgeInsets.all(
                kPadding,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ada catatan untuk Admin ?',
                    style: kWhiteFontStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: GetBuilder<PermintaanController>(
                        init: permintaanController,
                        id: 'notesTextField',
                        builder: (context) {
                          return TextField(
                            enabled: !permintaanController.isLoading.value,
                            maxLines: null,
                            onChanged: (x) {
                              permintaanController.setNotes();
                            },
                            textAlign: TextAlign.center,
                            controller: permintaanController.catatanController,
                            style: kWhiteFontStyle.copyWith(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(fontSize: 28, color: Colors.white60),
                              hintText: "Ketik disini",
                              border: InputBorder.none,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 300, maxHeight: 50.0),
              margin: const EdgeInsets.all(10),
              child: RoundedLoadingButton(
                successColor: Colors.white,
                borderRadius: 10,
                valueColor: kPrimary,
                color: Colors.white,
                child: Text(
                  'Proses',
                  style: kBlackFontStyle.copyWith(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
                controller: permintaanController.btnProsesController,
                onPressed: () async {
                  bool success = await permintaanController.prosesPermintaan();
                  if (success) {
                    permintaanController.btnProsesController.success();
                    await Future.delayed(const Duration(milliseconds: 400), () {
                      Get.offAllNamed('/success-illustration');
                    });
                  } else {
                    permintaanController.btnProsesController.error();
                    Get.snackbar(
                      'Error',
                      'ada kesalahan.',
                      backgroundColor: Colors.red.withOpacity(0.8),
                      snackPosition: SnackPosition.BOTTOM,
                      icon: const Icon(Icons.alarm),
                      shouldIconPulse: true,
                    );
                  }
                  await Future.delayed(const Duration(milliseconds: 500), () {
                    permintaanController.btnProsesController.reset();
                  });
                },
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            )
          ],
        ),
      ),
    );
  }
}

// ElevatedButton(
// onPressed: () {
// permintaanController.prosesPermintaan();
// Get.toNamed('/success-illustration');
// },
// style: ElevatedButton.styleFrom(
// primary: Colors.white,
// padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
// textStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
// ),
// child: Padding(
// padding: EdgeInsets.all(0),
// child: Container(
// alignment: Alignment.center,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Center(
// child: Text(
// 'Proses',
// style:
// kBlackFontStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
// ),
// ),
// Icon(
// Icons.arrow_forward,
// color: Colors.black,
// )
// ],
// ),
// ),
// ),
// ),
