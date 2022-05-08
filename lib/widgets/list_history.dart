import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:siap_baper/constant.dart';
import 'package:siap_baper/controllers/request_controller.dart';

import '../models/request_model.dart';

class ListHistory extends StatelessWidget {
  final RequestController requestController = Get.find(tag: 'requestController');

  ListHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestController>(
        id: 'fetchHistory',
        init: requestController,
        builder: (ctx) {
          if (requestController.isLoading.value) {
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
              itemCount: requestController.tempRequestHistoryList.length,
              itemBuilder: (ctx, x) {
                RequestData data = requestController.tempRequestHistoryList[x];
                return GestureDetector(
                    onTap: () {
                      Get.toNamed('/detail-ticket', arguments: {'noTicket': data.noTicket});
                    },
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
                          data.status.toString(),
                          style: kBlackFontStyle2.copyWith(
                            color: data.status == 'PENDING'
                                ? Colors.orange
                                : data.status == 'REJECT'
                                    ? Colors.red
                                    : Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        title: Text(
                          data.noTicket.toString(),
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
