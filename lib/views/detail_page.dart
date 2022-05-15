import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:siap_baper/constant.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeline_tile/timeline_tile.dart';

import '../controllers/request_controller.dart';

class DetailPage extends StatelessWidget {
  DetailPage({Key? key}) : super(key: key);
  final RequestController requestController = Get.find(tag: 'requestController');

  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('id', timeago.IdMessages());
    requestController.fetchNoTicket(Get.arguments['noTicket']);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: kPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Detail Ticket',
          style: kWhiteFontStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (requestController.fetchRequestData.value.status == 'ACCEPT' ||
              requestController.fetchRequestData.value.status == 'REJECT') {
            Get.snackbar(
              'Error',
              'Status Pengajuan sudah ${requestController.fetchRequestData.value.status}, tidak bisa malakukan penghapusan data',
              backgroundColor: Colors.red.withOpacity(0.6),
              snackPosition: SnackPosition.BOTTOM,
              icon: const Icon(Icons.alarm),
              shouldIconPulse: true,
            );
          } else {
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
              middleText:
                  'Anda yakin ${requestController.fetchRequestData.value.noTicket} akan di hapus ?',
              onConfirm: () async {
                bool success = await requestController
                    .deleteTicket(requestController.fetchRequestData.value.id!);
                if (success) {
                  requestController.removeRequestList(requestController.fetchRequestData.value.id!);
                  Get.back();
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Data berhasil di hapus',
                    backgroundColor: Colors.green,
                    snackPosition: SnackPosition.TOP,
                    icon: const Icon(Icons.check),
                    shouldIconPulse: true,
                  );
                } else {
                  Get.back();
                  Get.snackbar(
                    'Opss',
                    'ada masalah, data tidak dapat di hapus',
                    backgroundColor: Colors.red.withOpacity(0.7),
                    snackPosition: SnackPosition.TOP,
                    icon: const Icon(Icons.check),
                    shouldIconPulse: true,
                  );
                }
              },
            );
          }
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.delete),
      ),
      backgroundColor: kPrimary,
      body: SafeArea(
        child: Column(
          children: [
            Divider(
              height: 1,
              thickness: 1,
              color: kSecondary,
            ),
            const Spacer(),
            Container(
              color: kListCardColor,
              height: Get.height * 0.9 - 24,
              child: Obx(() {
                if (requestController.isLoadingDetail.value) {
                  return const Center(
                    child: SpinKitWave(
                      color: Colors.black,
                    ),
                  );
                } else {
                  int no = 0;
                  return ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: kPadding, bottom: 10, right: kPadding, left: kPadding),
                        child: Card(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(kPadding),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Nomor Ticket',
                                          style: kBlackFontStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${requestController.fetchRequestData.value.noTicket}',
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Tanggal',
                                          style: kBlackFontStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          DateFormat.yMMMd().format(
                                              requestController.fetchRequestData.value.createdAt!),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Catatan',
                                          style: kBlackFontStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            '${requestController.fetchRequestData.value.notes}',
                                            textAlign: TextAlign.end,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Status',
                                          style: kBlackFontStyle.copyWith(
                                              fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${requestController.fetchRequestData.value.status}',
                                          style: kBlackFontStyle2.copyWith(
                                            color: requestController
                                                        .fetchRequestData.value.status ==
                                                    'PENDING'
                                                ? Colors.orange
                                                : requestController.fetchRequestData.value.status ==
                                                        'REJECT'
                                                    ? Colors.red
                                                    : Colors.green,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(top: 10, bottom: 10, right: kPadding, left: kPadding),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(kPadding, 10, kPadding, 10),
                                child: Text(
                                  'Detail ',
                                  style: kBlackFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              DataTable(
                                headingRowHeight: 40,
                                sortAscending: true,
                                sortColumnIndex: 1,
                                dataRowHeight: 50,
                                showBottomBorder: false,
                                columns: [
                                  DataColumn(
                                      label: Text(
                                        'No',
                                        style:
                                            kBlackFontStyle.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      numeric: true),
                                  DataColumn(
                                      label: Text(
                                    'Nama',
                                    style: kBlackFontStyle.copyWith(fontWeight: FontWeight.bold),
                                  )),
                                  DataColumn(
                                      label: Text(
                                        'Qty',
                                        style:
                                            kBlackFontStyle.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      numeric: true),
                                  DataColumn(
                                      label: Text(
                                        'Acc Qty',
                                        style:
                                            kBlackFontStyle.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      numeric: true),
                                ],
                                rows: requestController.fetchRequestData.value.detail!.map((e) {
                                  no++;
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(no.toString(),
                                          style: kBlackFontStyle2, textAlign: TextAlign.right)),
                                      DataCell(Text('${e.product!.name}', style: kBlackFontStyle2)),
                                      DataCell(Text('${e.quantity}',
                                          style: kBlackFontStyle2, textAlign: TextAlign.right)),
                                      DataCell(Text('${e.accQuantity}',
                                          style: kBlackFontStyle2, textAlign: TextAlign.right))
                                    ],
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                          right: kPadding,
                          left: kPadding,
                        ),
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(kPadding, 10, kPadding, 10),
                                child: Text(
                                  'Log',
                                  style: kBlackFontStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Center(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children:
                                        requestController.fetchRequestData.value.timeLog!.map((e) {
                                      return _buildTimelineTile(
                                        time: timeago.format(e.createdAt!, locale: 'id'),
                                        subTitle: e.keterangan.toString(),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

TimelineTile _buildTimelineTile({
  String? time,
  String? subTitle,
  bool isLast = false,
}) {
  return TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.3,
    beforeLineStyle: LineStyle(color: kPrimary),
    indicatorStyle: const IndicatorStyle(
      indicatorXY: 0.3,
      drawGap: true,
      width: 30,
      height: 50,
    ),
    isLast: isLast,
    startChild: Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
        child: Text(
          time!,
          style: kBlackFontStyle.copyWith(fontSize: 12),
        ),
      ),
    ),
    endChild: Padding(
      padding: EdgeInsets.symmetric(horizontal: kPadding, vertical: 10),
      child: Text(
        subTitle!,
        style: kBlackFontStyle.copyWith(fontSize: 14),
      ),
    ),
  );
}
