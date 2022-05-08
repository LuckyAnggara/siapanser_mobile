import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:siap_baper/models/request_model.dart';

import '../services/api_services.dart';

class RequestController extends GetxController {
  var isLoading = false.obs;
  var isLoadingDetail = true.obs;
  RxList requestHistoryList = [].obs;
  RxList tempRequestHistoryList = [].obs;

  Rx<RequestData> fetchRequestData = RequestData(detail: []).obs;

  final HttpServices _httpServices = HttpServices();
  final TextEditingController searchHistoryController = TextEditingController();

  @override
  void onInit() {
    // fetchHistoryRequest();
    super.onInit();
  }

  void dispose() {
    searchHistoryController.dispose();
    super.dispose();
  }

  // TRIGER KETIKA LOGOUT
  void updateList() {
    requestHistoryList.value = [];
    tempRequestHistoryList.value = [];
    update(['fetchHistory']);
  }

  void fetchHistoryRequest() async {
    try {
      isLoading(true);
      var history = await _httpServices.fetchHistoryRequest();
      if (history != null) {
        requestHistoryList.value = history.data!.data!;
        tempRequestHistoryList.value = requestHistoryList;
      }
    } finally {
      isLoading(false);
      update(['fetchHistory']);
    }
  }

  void searchHistory(String noTicket) {
    try {
      isLoading(true);
      tempRequestHistoryList.value = requestHistoryList
          .where((e) => e.noTicket.toLowerCase().contains(noTicket.toLowerCase()))
          .toList();
    } finally {
      isLoading(false);
    }
  }

  void fetchNoTicket(String noTicket) async {
    try {
      isLoadingDetail(true);
      var data = await _httpServices.fetchNoTicket(noTicket: noTicket);
      if (data != null) {
        fetchRequestData.value = data;
      }
    } finally {
      isLoadingDetail(false);
    }
  }

  Future<bool> deleteTicket(int id) async {
    try {
      isLoadingDetail(true);
      var data = await _httpServices.deleteTicket(id: id);
      return data;
    } finally {
      isLoadingDetail(false);
    }
  }

  void removeRequestList(int id) {
    int index = requestHistoryList.indexWhere((element) => element.id == id);
    requestHistoryList.removeAt(index);
  }
}
