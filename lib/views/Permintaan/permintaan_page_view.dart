import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/views/Permintaan/Quantity.dart';
import 'package:siap_baper/views/Permintaan/search_name.dart';

import '../../controllers/permintaan_controller.dart';

class PermintaanPageView extends StatelessWidget {
  PermintaanPageView({Key? key}) : super(key: key);
  final PermintaanController permintaanController = Get.find(tag: 'permintaan_controller');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: permintaanController.pageController.value,
        children: [
          SearchName(),
          Quantity(),
        ],
      ),
    );
  }
}
