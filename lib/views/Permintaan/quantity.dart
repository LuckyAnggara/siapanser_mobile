import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:siap_baper/controllers/permintaan_controller.dart';
import 'package:supercharged/supercharged.dart';

import '../../constant.dart';

class Quantity extends StatelessWidget {
  Quantity({Key? key}) : super(key: key);
  final PermintaanController permintaanController = Get.find(tag: 'permintaan_controller');
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PermintaanController>(
        init: permintaanController,
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor:
                permintaanController.isQuantityRed.value ? '#912850'.toColor() : kPrimary,
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
                          permintaanController.isQuantityRed.value
                              ? 'Pengajuan melebihi saldo persediaan'
                              : 'Pengajuan berapa ${permintaanController.product.value.unit!.name} ?',
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
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: permintaanController.quantityProductController,
                          style: kWhiteFontStyle.copyWith(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(fontSize: 28, color: Colors.white60),
                            hintText:
                                "Ketik disini (max : ${permintaanController.product.value.quantity})",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Obx(() {
                        if (permintaanController.isQuantityFill.value) {
                          return Container(
                            constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                            margin: EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
                                permintaanController.addDetail();
                                Get.back();
                              },
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
                                  textStyle:
                                      const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                              child: Padding(
                                padding: EdgeInsets.all(0),
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
                                      Icon(
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
                          return SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
