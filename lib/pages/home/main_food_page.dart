import 'package:flutter/material.dart';
import 'package:marketify/pages/home/food_page_body.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  // add stful -> add MainFoodPage -> import package from Container()
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    // refresh indicator supaya ketika ada product baru yang ditambahkan dari database,
    // akan berubah atau ditambahkan ke ui
    // cara kerjanya pull down screen supaya refresh,
    // it will talked to the server, and refresh the content
    return RefreshIndicator(
        child: Column(
          children: [
            // HEADER SECTION
            Container(
              child: Container(
                margin: EdgeInsets.only(
                    top: Dimensions.height45, bottom: Dimensions.height15),
                // change margin for the header from top and bottom
                padding: EdgeInsets.only(
                    left: Dimensions.width20, right: Dimensions.width20),
                // change the padding header text supaya lebih ke dalam
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // move search bar to right side
                  children: [
                    /*Column(
                      // Header - text on the top left
                      children: [
                        BigText(text: "Marketify", color: AppColors.mainColor),
                        Row(
                          children: [
                            SmallText(text: "Badung", color: Colors.black54),
                            Icon(Icons.arrow_drop_down_rounded)
                          ],
                        )
                      ],
                    ),*/

                    // SEARCH ICON SECTION
                    /*Center(
                      //\\ make sure the icon on the center border
                      child: Container(
                        //\\ Header - search button on the top right
                        width: Dimensions.height45,
                        height: Dimensions.height45,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimensions.iconSize24,
                        ),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                      ),
                    )*/
                  ],
                ),
              ),
            ),

            // SHOW THE BODY SECTION
            Expanded(
                child: SingleChildScrollView(
              child: FoodPageBody(),
            )),
          ],
        ),
        onRefresh: _loadResource);
  }
}
