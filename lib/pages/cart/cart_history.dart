import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marketify/base/custom_app_bar.dart';
import 'package:marketify/base/no_data_page.dart';
import 'package:marketify/controllers/cart_controller.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/app_constants.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/cart_model.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // get the cart history from cart controller
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    // string is a date
    // int is value
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    // getting how many items per order
    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    // disini kita tahu kapan ordernya selesai
    var listCounter = 0;

    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Cart History", backButtonExist: false,),
      body: Column(
        children: [
          // HEADER APP BAR SECTION
          /*
          Container(
            height: Dimensions.height10 * 10,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: EdgeInsets.only(top: Dimensions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                ),
              ],
            ),
          ),
          */

          // BODY SECTION
          // container must have height
          // although we can use Expanded widget
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
                    child: Container(
                        // margin for content
                        margin: EdgeInsets.only(
                            top: Dimensions.height20,
                            left: Dimensions.width20,
                            right: Dimensions.width20),

                        // media query supaya bisa ngilangin padding yang ada diatas
                        child: MediaQuery.removePadding(
                          removeTop: true,
                          context: context,
                          child: ListView(
                            children: [
                              for (int i = 0; i < itemsPerOrder.length; i++)
                                // need container for bottom margin etc
                                Container(
                                  height: Dimensions.height30 * 4,
                                  // supaya textnya sedikit kebawah dari header bar
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.height20),
                                  child: Column(
                                    // supaya text start dari kiri
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    // TIME SECTION
                                    children: [
                                      timeWidget(listCounter),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        //supaya element start dari kiri dan kanan
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                              direction: Axis.horizontal,
                                              children: List.generate(
                                                  itemsPerOrder[i], (index) {
                                                // to prevent overflow
                                                if (listCounter <
                                                    getCartHistoryList.length) {
                                                  listCounter++;
                                                }

                                                // IMAGE SECTION
                                                // supaya image <=2
                                                return index <= 2
                                                    ? Container(
                                                        height: Dimensions
                                                                .height20 *
                                                            4,
                                                        width: Dimensions
                                                                .height20 *
                                                            4,
                                                        // supaya gambarnya tidak teralu dekat
                                                        margin: EdgeInsets.only(
                                                            right: Dimensions
                                                                    .width10 /
                                                                2),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                            .radius15 /
                                                                        2),
                                                            image: DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image: NetworkImage(AppConstants
                                                                        .BASE_URL +
                                                                    AppConstants
                                                                        .UPLOAD_URL +
                                                                    getCartHistoryList[
                                                                            listCounter -
                                                                                1]
                                                                        .img!))),
                                                      )
                                                    : Container();
                                              })),
                                          Container(
                                            height: Dimensions.height20 * 4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              // supaya text rata kanan
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                SmallText(
                                                  text: "Total",
                                                  color: AppColors.titleColor,
                                                ),
                                                BigText(
                                                  text: itemsPerOrder[i]
                                                          .toString() +
                                                      " Items",
                                                  color: AppColors.titleColor,
                                                ),

                                                //BUTTON ONE MORE SECTION
                                                GestureDetector(
                                                  onTap: () {
                                                    // time per order
                                                    var orderTime =
                                                        cartOrderTimeToList();

                                                    Map<int, CartModel>
                                                        moreOrder = {};

                                                    for (int j = 0;
                                                        j <
                                                            getCartHistoryList
                                                                .length;
                                                        j++) {
                                                      if (getCartHistoryList[j]
                                                              .time ==
                                                          orderTime[i]) {
                                                        // debug to get the product id
                                                        // print("The cart or product is : " + getCartHistoryList[j].id!.toString());
                                                        // print("Product info is: "+ jsonEncode(getCartHistoryList[j]));
                                                        moreOrder.putIfAbsent(
                                                            getCartHistoryList[j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))));
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .setItems = moreOrder;
                                                    Get.find<CartController>()
                                                        .addToCartList();
                                                    Get.toNamed(RouteHelper.getCartPage(0, "cart-history"));

                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Dimensions
                                                                    .width10,
                                                            vertical: Dimensions
                                                                    .height10 /
                                                                2),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                                  .radius15 /
                                                              3),
                                                      border: Border.all(
                                                          width: 1,
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
                                                    child: SmallText(
                                                        text: "one more",
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          ),
                        )))
                : SizedBox(
                    height: MediaQuery.of(context).size.height / 1.5,
                    child: const Center(
                      child: NoDataPage(
                        text: "You didn't buy anything so far!",
                        imgPath: "assets/image/box_empty.png",
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }
}
