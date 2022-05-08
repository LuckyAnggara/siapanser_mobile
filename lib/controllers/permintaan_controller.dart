import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siap_baper/controllers/request_controller.dart';
import 'package:siap_baper/models/permintaan_model.dart';
import 'package:siap_baper/models/product_model.dart';

import '../services/api_services.dart';
import 'login_controller.dart';

class PermintaanController extends GetxController {
  var isLoading = false.obs;

  var isQuantityFill = false.obs;
  RxList productSearchPermintaanList = [].obs;
  RxList<PermintaanProduct> detailPermintaan = <PermintaanProduct>[].obs;
  Rx<PermintaanModel> permintaanModal = PermintaanModel(userId: null, detail: [], notes: '').obs;
  Rx<Product> product = Product().obs;
  final HttpServices _httpServices = HttpServices();
  final LoginController loginController = Get.find(tag: 'loginController');
  final RequestController requestController = Get.find(tag: 'requestController');

  TextEditingController searchProductController = TextEditingController();
  TextEditingController quantityProductController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  Rx<PageController> pageController = PageController(
    initialPage: 0,
  ).obs;

  RoundedLoadingButtonController btnProsesController = RoundedLoadingButtonController();

  @override
  void onInit() {
    super.onInit();
    quantityProductController.addListener(() {
      if (quantityProductController.text.isNotEmpty) {
        isQuantityFill.value = true;
      } else {
        isQuantityFill.value = false;
      }
    });
  }

  @override
  void dispose() {
    searchProductController.dispose();
    quantityProductController.dispose();
    catatanController.dispose();
    pageController.value.dispose();
    super.dispose();
  }

  void addDetail() {
    if (detailPermintaan.where((e) => e.productId == product.value.id).isNotEmpty) {
      int index = detailPermintaan.indexWhere((e) => e.productId == product.value.id);
      int quantity = detailPermintaan[index].quantity;
      PermintaanProduct item = PermintaanProduct(
        name: product.value.name!,
        productId: product.value.id!,
        quantity: quantity,
        unitName: product.value.unit!.name,
      );
      detailPermintaan.removeAt(index);
      detailPermintaan.add(item);
    } else {
      PermintaanProduct item = PermintaanProduct(
        name: product.value.name!,
        productId: product.value.id!,
        quantity: int.parse(quantityProductController.text),
        unitName: product.value.unit!.name,
      );
      detailPermintaan.add(item);
    }

    quantityProductController.clear();
    searchProductController.clear();
  }

  void deleteItem(PermintaanProduct e) {
    detailPermintaan.remove(e);
  }

  void setNotes() {
    permintaanModal.update((val) {
      val?.notes = catatanController.value.text;
    });
  }

  void nextPage() {
    pageController.value
        .nextPage(duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  Future<bool> prosesPermintaan() async {
    permintaanModal.update((val) {
      val?.userId = loginController.profile.value.id;
    });
    try {
      isLoading(true);
      permintaanModal.update((val) {
        val?.detail.addAll(detailPermintaan);
      });
      update(['notesTextField']);

      return await _httpServices.postPermintaan(permintaanModel: permintaanModal.value);
    } finally {
      isLoading(false);
      requestController.fetchHistoryRequest();
    }
    return false;
  }

  void searchProductPermintaan(String str) async {
    try {
      isLoading(true);
      var products = await _httpServices.searchProduct(str: str, limit: 2);
      if (products != null) {
        productSearchPermintaanList.value = products.data!.data!;
      }
      if (str == null || str == '') {
        productSearchPermintaanList.value = [];
      }
    } finally {
      isLoading(false);
    }
  }
}
