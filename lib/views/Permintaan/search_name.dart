import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:siap_baper/controllers/permintaan_controller.dart';

import '../../constant.dart';

class SearchName extends StatelessWidget {
  SearchName({Key? key}) : super(key: key);
  final PermintaanController permintaanController = Get.find(tag: 'permintaan_controller');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
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
                Text(
                  'Persediaan Apa yang Kamu cari ?',
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
                  child: TextField(
                    onChanged: (x) {
                      permintaanController.searchProductPermintaan(x);
                    },
                    textAlign: TextAlign.center,
                    controller: permintaanController.searchProductController,
                    style: kWhiteFontStyle.copyWith(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    ),
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(fontSize: 28, color: Colors.white60),
                      hintText: "Ketik disini",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Expanded(
                  child: Obx(() {
                    if (permintaanController.isLoading.value) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.black,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        physics: const BouncingScrollPhysics(),
                        itemCount: permintaanController.productSearchPermintaanList.length,
                        itemBuilder: (ctx, x) {
                          var data = permintaanController.productSearchPermintaanList[x];
                          return Container(
                            margin: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                permintaanController.product.value =
                                    permintaanController.productSearchPermintaanList[x];
                                permintaanController.nextPage();
                                permintaanController.searchProductController.clear();
                                permintaanController.productSearchPermintaanList.value = [];
                              },
                              child: Card(
                                shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: Colors.white70),
                                ),
                                elevation: 8,
                                shadowColor: Colors.black12,
                                margin: EdgeInsets.symmetric(
                                  horizontal: kPaddingHorizontal,
                                  vertical: 5,
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                  title: Center(
                                    child: Text(
                                      data.name.toString(),
                                      style: kBlackFontStyle.copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
