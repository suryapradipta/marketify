import 'package:flutter/material.dart';
import 'package:marketify/controllers/cart_controller.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/pages/auth/sign_in_page.dart';
import 'package:marketify/pages/auth/sign_up_page.dart';
import 'package:marketify/pages/splash/splash_page.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:get/get.dart';
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
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          // remove debug label on the top right
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',

          // home: SignInPage(),
          // home: SplashScreen(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,

        );
      });
    });
  }
}