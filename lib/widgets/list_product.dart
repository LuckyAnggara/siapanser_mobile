import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../constant.dart';
import '../controllers/product_controller.dart';

class ListProduct extends StatelessWidget {
  final ProductController productController = Get.find(tag: 'product_controller');

  ListProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (productController.isLoading.value) {
        return const Center(
          child: SpinKitWave(
            color: Colors.black,
          ),
        );
      } else {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: productController.productList.length,
          itemBuilder: (ctx, x) {
            var data = productController.productList[x];
            return GestureDetector(
                onTap: () {},
                child: Card(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(color: Colors.white54),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black54,
                  margin: EdgeInsets.symmetric(
                    horizontal: kPaddingHorizontal,
                    vertical: 5,
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                    trailing: Text(
                      '${data.quantity.toString()} ${data.unit.name}',
                      style: kBlackFontStyle2.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    title: Text(
                      data.name.toString(),
                      style: kBlackFontStyle.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ));
          },
        );
      }
    });
  }
}

// Container(
// decoration: BoxDecoration(
// color: kColorMain,
// boxShadow: [],
// borderRadius: BorderRadius.all(
// Radius.circular(
// 20,
// ),
// ),
// ),
// padding: EdgeInsets.symmetric(
// vertical: 5,
// ),
// child: Row(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// SizedBox(
// height: 35,
// width: 35,
// child: Container(
// decoration: BoxDecoration(
// color: Colors.red,
// borderRadius: BorderRadius.all(
// Radius.circular(45),
// ),
// ),
// ),
// ),
// SizedBox(
// width: 20,
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// data.name,
// style: blackFontStyle,
// ),
// SizedBox(
// height: 5,
// ),
// ],
// ),
// Spacer(),
// ],
// ),
// ),
