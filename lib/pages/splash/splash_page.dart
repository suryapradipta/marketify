import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

// kalo mau isi animation harus isi Ticker...
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource(bool reload) async {
    await Get.find<PopularProductController>().getPopularProductList(reload);
    await Get.find<RecommendedProductController>().getRecommendedProductList(reload);
  }


  @override
  void initState() {
    super.initState();
    _loadResource(true);


    // duration animation
    controller =
        AnimationController(
            vsync: this,
            duration: const Duration(seconds: 2))..forward();

    // type of animation
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear);

    Timer(
        const Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        // center vertically
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/image/logo part 2.png",
              width: Dimensions.splashImg,
            ),
          )
        ],
      ),
    );
  }
}
