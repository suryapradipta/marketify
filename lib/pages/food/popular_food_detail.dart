import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketify/controllers/cart_controller.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/pages/home/main_food_page.dart';
import 'package:marketify/utils/app_constants.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_column.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../cart/cart_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;

  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String timeWidget(String date) {
      var outputDate = DateTime.now().toString();
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("MM/dd/yyyy");
      outputDate = outputFormat.format(inputDate);
      return outputDate;
    }
    
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());

    // print("page is id "+pageId.toString());
    // print("product name is "+ product.name.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // BACKGROUND IMAGE
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.UPLOAD_URL +
                            product.img!))),
              )),

          // ICON WIDGETS ON THE TOP
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // "GestureDetector" supaya bisa dipencet
                  GestureDetector(
                      onTap: () {
                        // Get.to untuk beralih halaman
                        if (page == "cartpage") {
                          Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));

                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),

                  // CART ICON
                  GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        if (controller.totalItems >= 0)
                          Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));

                      },
                      child: Stack(
                        children: [
                          AppIcon(icon: Icons.shopping_cart_outlined),
                          controller.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: AppColors.mainColor,
                                  ),
                                )
                              : Container(),

                          // TEXT IN CART ICON
                          if (Get.find<PopularProductController>().totalItems >=
                                  1 &&
                              Get.find<PopularProductController>().totalItems <
                                  10)
                            Positioned(
                              right: 6,
                              top: 3,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          else if (Get.find<PopularProductController>()
                                  .totalItems >=
                              10)
                            Positioned(
                              right: 3,
                              top: 3,
                              child: BigText(
                                text: Get.find<PopularProductController>()
                                    .totalItems
                                    .toString(),
                                size: 12,
                                color: Colors.white,
                              ),
                            )
                          else
                            Container()
                        ],
                      ),
                    );
                  })
                ],
              )),

          // INTRODUCTION DESCRIPTION TO FOOD
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize - 20,
              child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    top: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(Dimensions.radius20),
                        topLeft: Radius.circular(Dimensions.radius20)),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: product.name!,
                          size: Dimensions.font26,
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        //\\ space between title and the bottom of title
                        // comment section
                        Row(
                          children: [
                            //\\ children takes list of children //\\ can put children one by one, or using list of children
                            Wrap(
                              //\\ make the icon horizontally
                              children: List.generate(product.stars!, (index) {
                                return Icon(
                                  Icons.star,
                                  color: AppColors.mainColor,
                                  size: 15,
                                );
                              }), //\\ add icon stars
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            SmallText(text: "("+product.stars!.toString() +")"),

                            SizedBox(
                              width: 5,
                            ),
                            SmallText(text: "stars"),

                            SizedBox(
                              width: Dimensions.width20,
                            ),
                            Icon(
                              Icons.date_range,
                              color: AppColors.mainColor,
                              size: 15,),
                            SizedBox(
                              width: Dimensions.width10 - 5,
                            ),
                            SmallText(text: ""+timeWidget(product.createdAt.toString())+""),
                            SmallText(text: " offered"),



                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        // time and distance
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //\\ give space between icon text in description box
                          children: [
                            IconAndTextWidget(
                                icon: Icons.circle_sharp,
                                text: "Fresh item",
                                iconColor: AppColors.iconColor1),
                            IconAndTextWidget(
                                icon: Icons.location_on,
                                text: product.location,
                                iconColor: AppColors.mainColor),
                            IconAndTextWidget(
                                icon: Icons.favorite_outlined,
                                text: "(" +product.selected_people.toString() +")"+
                                    " selected people",
                                iconColor: AppColors.iconColor2),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    BigText(text: "Introduce"),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    // singgle child work together expanded widget to make it scrollable
                    Expanded(
                        child: SingleChildScrollView(
                            child: ExpandableTextWidget(
                                text: product.description!)))
                  ],
                ),
              ))
        ],
      ),

      // ADD TO CART SECTION
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(
              top: Dimensions.height30,
              bottom: Dimensions.height30,
              left: Dimensions.width20,
              right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20 * 2),
                topRight: Radius.circular(Dimensions.radius20 * 2),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,5),
                        blurRadius: 10,
                        color: Colors.grey[200]!
                      )
                    ],
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
                child: Row(
                  children: [
                    // ICON ADD AND REMOVE FOOTBAR SECTION
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(false);
                        },
                        child: Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        )),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),

                    // QUANTITY SECTION
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    GestureDetector(
                        onTap: () {
                          popularProduct.setQuantity(true);
                        },
                        child: Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ))
                  ],
                ),
              ),

              // PRICE AND ADD TO CART SECTION
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(
                    text: "\$ ${product.price!} | Add to cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0,5),
                          blurRadius: 10,
                          color: AppColors.mainColor.withOpacity(0.3),
                        )
                      ],
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
