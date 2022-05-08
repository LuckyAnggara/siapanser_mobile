import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siap_baper/constant.dart';

import '../controllers/request_controller.dart';
import '../widgets/list_history.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);
  final RequestController requestController = Get.find(tag: 'requestController');

  @override
  Widget build(BuildContext context) {
    requestController.fetchHistoryRequest();
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
          'Data Pengajuan',
          style: kWhiteFontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.hardEdge,
          fit: StackFit.loose,
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                SizedBox(
                  child: Column(
                    children: [
                      Divider(
                        height: 1,
                        thickness: 1,
                        color: kSecondary,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: kPadding),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 30.0,
                              margin: const EdgeInsets.only(left: 00.0, right: 10.0),
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (val) {
                                  requestController.searchHistory(val);
                                },
                                controller: requestController.searchHistoryController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      print('bbb');
                                      requestController.searchHistory(
                                          requestController.searchHistoryController.text);
                                    },
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Cari pengajuan (Nomor Ticket)',
                                  hintStyle: kWhiteFontStyle2.copyWith(fontSize: 14),
                                ),
                                style: kWhiteFontStyle2.copyWith(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SimpleBuilder(builder: (ctx) {
                        return Container(
                          padding: EdgeInsets.only(left: kPadding + 14),
                          width: double.infinity,
                          child: Text(
                            '${requestController.tempRequestHistoryList.length} Data ditemukan',
                            style: kWhiteFontStyle,
                          ),
                        );
                      })
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  color: kListCardColor,
                  height: Get.height * 0.55,
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.75,
              child: ListHistory(),
            ),
          ],
        ),
      ),
    );
  }
}
