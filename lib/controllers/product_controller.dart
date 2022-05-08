import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  RxList productList = [].obs;

  final HttpServices _httpServices = HttpServices();
  final TextEditingController searchProductController = TextEditingController();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void dispose() {
    searchProductController.dispose();
    super.dispose();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await _httpServices.fetchProducts();
      if (products != null) {
        productList.value = products.data!.data!;
      }
    } finally {
      isLoading(false);
    }
  }

  void searchProducts(String str) async {
    try {
      isLoading(true);
      var products = await _httpServices.searchProduct(str: str);
      if (products != null) {
        productList.value = products.data!.data!;
      }
    } finally {
      isLoading(false);
    }
  }
}
