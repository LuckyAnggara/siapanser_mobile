import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/constant.dart';

import '../controllers/permintaan_controller.dart';
import '../controllers/product_controller.dart';

class PermintaanPage extends StatelessWidget {
  PermintaanPage({Key? key}) : super(key: key);
  final ProductController productController =
      Get.put(ProductController(), tag: 'product_controller');
  final PermintaanController permintaanController =
      Get.put(PermintaanController(), tag: 'permintaan_controller');

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
        title: Text(
          'Permintaan Persediaan',
          style: kWhiteFontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.end, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 5, top: 5),
            child: FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: kPrimary,
              onPressed: () {
                Get.toNamed('/tambah-permintaan');
              },
              child: Icon(
                Icons.add,
              ),
            ),
          ), //button first
          Obx(() {
            return permintaanController.detailPermintaan.value.length > 0
                ? Container(
                    margin: EdgeInsets.only(right: 5, top: 10),
                    child: FloatingActionButton.extended(
                      heroTag: "btn1",
                      onPressed: () {
                        Get.toNamed(
                          '/tambah-permintaan/notes',
                        );
                        //action code for button 2
                      },
                      backgroundColor: kPrimary,
                      label: Text('Submit'),
                    ),
                  )
                : SizedBox();
          }), // button second

          // button third

          // Add more buttons here
        ],
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height - 50,
            decoration: BoxDecoration(
              color: kColorMain,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: kPadding, right: kPadding, top: kPadding, bottom: 5),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: kSecondary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              15,
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'No',
                                  style: kWhiteFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  'Nama',
                                  style: kWhiteFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Quantity',
                              style: kWhiteFontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: kPadding,
                      right: kPadding,
                      bottom: kPadding,
                    ),
                    child: Obx(() {
                      int total = 0;
                      return Column(
                          children: permintaanController.detailPermintaan.map((e) {
                        total++;
                        return GestureDetector(
                          onLongPress: () {
                            Get.defaultDialog(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: kPadding,
                                vertical: 10,
                              ),
                              buttonColor: kSecondary,
                              title: 'Hapus Data',
                              titleStyle: kWhiteFontStyle,
                              middleTextStyle: kWhiteFontStyle.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                              confirmTextColor: Colors.red,
                              textConfirm: 'Hapus',
                              textCancel: 'Cancel',
                              backgroundColor: kPrimary,
                              middleText: 'Anda yakin ${e.name} akan di hapus dari daftar ?',
                              onConfirm: () {
                                permintaanController.detailPermintaan.remove(e);
                                Get.back();
                                Get.snackbar(
                                  'Success',
                                  'Data berhasil di hapus',
                                  backgroundColor: Colors.green,
                                  snackPosition: SnackPosition.TOP,
                                  icon: const Icon(Icons.check),
                                  shouldIconPulse: true,
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  15,
                                ),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      total.toString(),
                                      style: kBlackFontStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Text(
                                      e.name,
                                      style: kBlackFontStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${e.quantity} ${e.unitName}',
                                  style: kBlackFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList());
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
