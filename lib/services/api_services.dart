import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:siap_baper/models/request_model.dart';

import '../constant.dart';
import '../controllers/local_storage_controller.dart';
import '../models/auth_model.dart';
import '../models/permintaan_model.dart';
import '../models/product_model.dart';

class HttpServices {
  final LocalStorageController localStorageController =
      Get.find(tag: 'localStorageController');
  final Dio _dio = Dio();

  Future<ProductModel?> fetchProducts() async {
    try {
      var response =
          await _dio.get('${ApiConstants.baseUrl}/product?limit=100');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<ProductModel?> searchProduct(
      {required String str, int limit = 100}) async {
    try {
      var response = await _dio
          .get('${ApiConstants.baseUrl}/product?name=$str&limit=$limit');
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> postPermintaan(
      {required PermintaanModel permintaanModel}) async {
    var response = await _dio.post(
      '${ApiConstants.baseUrl}/request/store',
      data: json.encode(permintaanModel.toJson()),
      options: Options(
        headers: {
          "Authorization": localStorageController.getToken,
        },
      ),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
    // return response;
  }

  Future<dynamic> auth(LoginModel data) async {
    try {
      var response = await _dio.post(
        '${ApiConstants.baseUrl}/login',
        data: json.encode(
          {
            'nip': data.nip,
            'password': data.password,
          },
        ),
      );
      if (response.statusCode == 200) {
        Token token = Token.fromJson(response.data);
        localStorageController.setToken(token);
        return getProfileData();
      }
      if (response.statusCode == 403) {
        return 'deactive';
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<UserModel?> getProfileData() async {
    try {
      var responseProfile = await _dio.get(
        '${ApiConstants.baseUrl}/profile',
        options: Options(
          headers: {
            "Authorization": localStorageController.getToken,
          },
        ),
      );
      if (responseProfile.statusCode == 200) {
        return UserModel.fromJson(responseProfile.data);
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<RequestModel?> fetchHistoryRequest() async {
    try {
      var response = await _dio.get(
        '${ApiConstants.baseUrl}/request?limit=200',
        options: Options(
          headers: {
            "Authorization": localStorageController.getToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return RequestModel.fromJson(response.data);
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<RequestData?> fetchNoTicket({required String noTicket}) async {
    try {
      var response = await _dio
          .get('${ApiConstants.baseUrl}/request/get?no_ticket=$noTicket');
      if (response.statusCode == 200) {
        return RequestData.fromJson(response.data['data']);
      } else {
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> deleteTicket({required int id}) async {
    try {
      var response = await _dio.delete(
        '${ApiConstants.baseUrl}/request/destroy/$id',
        options: Options(
          headers: {
            "Authorization": localStorageController.getToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  Future<bool> changePassword(
      {required ChangePasswordModel changePasswordModel}) async {
    try {
      var response = await _dio.post(
        '${ApiConstants.baseUrl}/change-password',
        data: json.encode(changePasswordModel.toJson()),
        options: Options(
          headers: {
            "Authorization": localStorageController.getToken,
          },
        ),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }
}
