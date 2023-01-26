import 'package:get/get.dart';
import 'package:marketify/base/show_custom_snakbar.dart';
import 'package:marketify/routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      showCustomSnackBar(response.statusText!);
    }

  }
}