import 'package:flutter/material.dart';
import 'package:marketify/controllers/cart_controller.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/pages/start/welcome_page.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:get/get.dart';
import 'package:marketify/utils/colors.dart';
import 'controllers/recommended_product_controller.dart';
import 'helper/dependencies.dart' as dep; // as dependencies

Future<void> main() async {
  // make sure dependencies load correctly, and wait until dep loaded
  WidgetsFlutterBinding.ensureInitialized();

  // load dependencies
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // supaya cart repo dan controllernya bisa jalan
    // supaya local storage data bisa di load
    Get.find<CartController>().getCartData();

    // ini cara save things in memory,
    // Get builder harus dipanggil sebelum GetMaterialApp
    return GetBuilder<PopularProductController>(builder: (_) {
      return GetBuilder<RecommendedProductController>(builder: (_) {
        return GetMaterialApp(
          // remove debug label on the top right
          debugShowCheckedModeBanner: false,
          title: 'Marketify',

          // home: SignInPage(),

          initialRoute: RouteHelper.welcomePage,
          getPages: RouteHelper.routes,
          theme:
              ThemeData(primaryColor: AppColors.mainColor, fontFamily: "Lato"),
        );
      });
    });
  }
}
