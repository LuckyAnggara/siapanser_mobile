import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:siap_baper/controllers/local_storage_controller.dart';
import 'package:siap_baper/controllers/request_controller.dart';
import 'package:siap_baper/models/auth_model.dart';

import '../services/api_services.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  RxBool login = false.obs;
  RxBool passwordVisible = false.obs;
  var isPasswordLamaFill = false.obs;
  var isPasswordBaruFill = false.obs;

  final HttpServices _httpServices = HttpServices();
  Rx<UserModel> profile = UserModel().obs;
  LocalStorageController localStorageController = LocalStorageController();
  RequestController requestController = Get.find(tag: 'requestController');
  TextEditingController nipController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordLamaController = TextEditingController();
  TextEditingController passwordBaruController = TextEditingController();
  Rx<PageController> changePasswordPageController = PageController(
    initialPage: 0,
  ).obs;

  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();

  RoundedLoadingButtonController btnChangePasswordController =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    passwordLamaController.addListener(() {
      if (passwordLamaController.text.isNotEmpty) {
        isPasswordLamaFill.value = true;
      } else {
        isPasswordLamaFill.value = false;
      }
    });

    passwordBaruController.addListener(() {
      if (passwordBaruController.text.isNotEmpty) {
        isPasswordBaruFill.value = true;
      } else {
        isPasswordBaruFill.value = false;
      }
    });

    if (profile.value.name == null && localStorageController.getToken != null) {
      getProfileData();
    }
    // TODO: implement onInit
    super.onInit();
  }

  void callUser() {}

  @override
  void dispose() {
    nipController.dispose();
    passwordController.dispose();
    passwordBaruController.dispose();
    passwordLamaController.dispose();
    super.dispose();
  }

  Future<bool> authLogin() async {
    try {
      LoginModel loginModel = LoginModel(
        nip: nipController.text,
        password: passwordController.text,
      );
      isLoading(true);
      UserModel? user = await _httpServices.auth(loginModel);
      if (user != null) {
        profile.value = user;
        localStorageController.setLogin(true);
        return true;
      }
    } finally {
      isLoading(false);
    }
    return false;
  }

  Future getProfileData() async {
    UserModel? user = await _httpServices.getProfileData();
    if (user != null) {
      profile.value = user;
      localStorageController.setLogin(true);
    }
  }

  Future<bool> changePassword() async {
    ChangePasswordModel changePasswordModel = ChangePasswordModel(
        passwordLama: passwordLamaController.text,
        passwordBaru: passwordBaruController.text);
    try {
      isLoading(true);
      var result = await _httpServices.changePassword(
          changePasswordModel: changePasswordModel);
      return result;
    } finally {
      isLoading(false);
      passwordBaruController.clear();
      passwordLamaController.clear();
    }
  }

  void changePasswordNextPage() {
    changePasswordPageController.value.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void logout() {
    localStorageController.destroyToken();
    localStorageController.setLogin(false);
    requestController.updateList();
    profile.value = UserModel();
  }
}
