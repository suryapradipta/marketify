import 'package:flutter/material.dart';
import 'package:marketify/controllers/auth_controller.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/controllers/recommended_product_controller.dart';
import 'package:marketify/utils/app_constants.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/common_text_button.dart';
import '../../base/custom_app_bar.dart';
import '../../base/no_data_page.dart';
import '../../base/show_custom_snakbar.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/order_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/place_order_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/styles.dart';
import '../../widgets/app_text_field.dart';
import '../order/delivery_options.dart';
import '../order/payment_option_button.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBar(title: "Your Cart"),
      body: Stack(
        children: [
          // ICON HEADER SECTION START
          /*Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  */ /*
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.iconSize24,
                  ),
                  */ /*
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),

                  
                  SizedBox(
                    width: Dimensions.width20 * 5,
                  ),
                  
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: Container(
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  */ /*
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    size: Dimensions.iconSize24,
                  ),
                  */ /*
                ],
              )),*/
          // ICON HEADER SECTION END

          // BODY SECTION START
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.length > 0
                ? Positioned(
                    top: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimensions.height15),
                      // remove padding top
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,

                        // use get builder to access the controller
                        child: GetBuilder<CartController>(
                            builder: (cartController) {
                          var _cartList = cartController.getItems;
                          return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (_, index) {
                                return Container(
                                  width: double.maxFinite,
                                  height: Dimensions.height20 * 5,
                                  child: Row(
                                    children: [
                                      // IMAGE SECTION START
                                      GestureDetector(
                                        // to allow redirect to food details page
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cartpage"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommendedProductList
                                                .indexOf(
                                                    _cartList[index].product!);
                                            if (recommendedIndex < 0) {
                                              Get.snackbar("History Product",
                                                  "Product review is not available for history products!",
                                                  backgroundColor:
                                                      AppColors.mainColor,
                                                  colorText: Colors.white);
                                            } else {
                                              Get.toNamed(RouteHelper
                                                  .getRecommendedFood(
                                                      recommendedIndex,
                                                      "cartpage"));
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: Dimensions.height20 * 5,
                                          height: Dimensions.height20 * 5,
                                          margin: EdgeInsets.only(
                                              bottom: Dimensions.height10),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          cartController
                                                              .getItems[index]
                                                              .img!)),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radius20),
                                              color: Colors.white),
                                        ),
                                      ),

                                      // space between text and image
                                      SizedBox(
                                        width: Dimensions.width10,
                                      ),

                                      // TEXT SECTION START
                                      // takes all available space of parent container
                                      Expanded(
                                          child: Container(
                                        height: Dimensions.height20 * 5,
                                        child: Column(
                                          // want start from beginning
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,

                                          // supaya ada vertical space atas bawah
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            // food name
                                            BigText(
                                              text: cartController
                                                  .getItems[index].name!,
                                              color: Colors.black54,
                                            ),
                                            // food tag

                                            SmallText(text: "Fresh"),

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text: "\$ " +
                                                      cartController
                                                          .getItems[index].price
                                                          .toString(),
                                                  color: Colors.redAccent,
                                                ),

                                                //=========COPYABLE=========
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.height10,
                                                      bottom:
                                                          Dimensions.height10,
                                                      left: Dimensions.width10,
                                                      right:
                                                          Dimensions.width10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20),
                                                      color: Colors.white),
                                                  child: Row(
                                                    children: [
                                                      // add and remove icon
                                                      GestureDetector(
                                                          onTap: () {
                                                            cartController.addItem(
                                                                _cartList[index]
                                                                    .product!,
                                                                -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor,
                                                          )),

                                                      SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2,
                                                      ),

                                                      // food qty
                                                      BigText(
                                                          text: _cartList[index]
                                                              .quantity
                                                              .toString()),

                                                      SizedBox(
                                                        width:
                                                            Dimensions.width10 /
                                                                2,
                                                      ),

                                                      GestureDetector(
                                                        onTap: () {
                                                          cartController
                                                              .addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                          // debug
                                                          print("being tapped");
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          color: AppColors
                                                              .signColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                //=========COPYABLE=========
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                );
                              });
                        }),
                      ),
                    ))
                : NoDataPage(
                    text: "Your shopping cart is empty!",
              imgPath: "assets/image/empty_shopping_cart.png",

            );
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(builder: (cartController) {
          return Container(
              height: Dimensions.bottomHeightBar + 50,
              padding: EdgeInsets.only(
                  top: Dimensions.height10,
                  bottom: Dimensions.height10,
                  left: Dimensions.width20,
                  right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20 * 2),
                    topRight: Radius.circular(Dimensions.radius20 * 2),
                  )),
              child: cartController.getItems.length > 0
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) {
                                    return Column(
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      Dimensions.radius20),
                                                  topRight: Radius.circular(
                                                      Dimensions.radius20),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left:
                                                            Dimensions.width20,
                                                        right:
                                                            Dimensions.width20,
                                                        top: Dimensions
                                                            .height20),
                                                    height: 520,
                                                    child: Column(
                                                      children: [
                                                        PaymentOptionButton(
                                                            icon: Icons.money,
                                                            title:
                                                                'Cash on Delivery',
                                                            subTitle:
                                                                'You pay after getting your products',
                                                            index: 0),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height10,
                                                        ),
                                                        PaymentOptionButton(
                                                            icon: Icons
                                                                .paypal_outlined,
                                                            title:
                                                                'Digital Payment',
                                                            subTitle:
                                                                'Safer and Faster Way of Payment',
                                                            index: 1),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height30,
                                                        ),
                                                        Text(
                                                          "Delivery Options",
                                                          style: robotoMedium,
                                                        ),
                                                        SizedBox(
                                                          height: Dimensions
                                                                  .height10 /
                                                              2,
                                                        ),
                                                        DeliveryOptions(
                                                            value: "delivery",
                                                            title:
                                                                "home delivery",
                                                            amount: double
                                                                .parse(Get.find<
                                                                        CartController>()
                                                                    .totalAmount
                                                                    .toString()),
                                                            isFree: false),
                                                        SizedBox(
                                                          height: Dimensions
                                                                  .height10 /
                                                              2,
                                                        ),
                                                        DeliveryOptions(
                                                            value: "take away",
                                                            title: "take away",
                                                            amount: 10.0,
                                                            isFree: true),
                                                        SizedBox(
                                                          height: Dimensions
                                                              .height20,
                                                        ),
                                                        Text(
                                                          "Additional Notes",
                                                          style: robotoMedium,
                                                        ),
                                                        AppTextField(
                                                          maxLines: true,
                                                          textController:
                                                              _noteController,
                                                          hintText: "",
                                                          icon: Icons.note,
                                                        ),
                                                      ],
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  })
                              .whenComplete(() => orderController
                                  .setFoodNote(_noteController.text.trim())),

                          child: SizedBox(
                            width: double.maxFinite,
                            child: CommonTextButton(text: "Payment Option"),
                          ),
                        ),

                        SizedBox(
                          height: Dimensions.height10,
                        ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  top: Dimensions.height20,
                                  bottom: Dimensions.height20,
                                  left: Dimensions.width20,
                                  right: Dimensions.width20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white),
                              child: Row(
                                children: [
                                  // PRICE SECTION
                                  BigText(
                                      text: "\$ " +
                                          cartController.totalAmount
                                              .toString()),

                                  SizedBox(
                                    width: Dimensions.width10 / 2,
                                  ),
                                ],
                              ),
                            ),

                            // PRICE AND ADD TO CART SECTION
                            GestureDetector(
                                onTap: () {
                                  // popularProduct.addItem(product);

                                  // ADD TO THE ORDER TO HISTORY WHILE CHECKOUT
                                  // cartController.addToHistory();

                                  if (Get.find<AuthController>()
                                      .userLoggedIn()) {
                                    print("logged in?");
                                    if (Get.find<LocationController>()
                                        .addressList
                                        .isEmpty) {
                                      Get.toNamed(RouteHelper.getAddressPage());
                                    } else {
                                      var location =
                                          Get.find<LocationController>()
                                              .getUserAddress();
                                      var cart =
                                          Get.find<CartController>().getItems;
                                      var user =
                                          Get.find<UserController>().userModel;
                                      PlaceOrderBody placeOrder =
                                          PlaceOrderBody(
                                              cart: cart,
                                              orderAmount: 100.0,
                                              orderNote:
                                                  orderController.foodNote,
                                              address: location.address,
                                              latitude: location.latitude,
                                              longitude: location.longitude,
                                              contactPersonName: user!.name,
                                              contactPersonNumber: user.phone,
                                              scheduleAt: '',
                                              distance: 10.0,
                                              paymentMethod: orderController
                                                          .paymentIndex ==
                                                      0
                                                  ? 'cash_on_delivery'
                                                  : 'digital_payment',
                                              orderType:
                                                  orderController.orderType);

                                      Get.find<OrderController>()
                                          .placeOrder(placeOrder, _callback);
                                    }
                                  } else {
                                    Get.toNamed(RouteHelper.getSignInPage());
                                  }
                                },
                                child: CommonTextButton(
                                  text: "Check Out",
                                ))
                          ],
                        ),
                      ],
                    )
                  : Container());
        });
      }),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();

      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(RouteHelper.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.offNamed(RouteHelper.getPaymentPage(
            orderID, Get.find<UserController>().userModel!.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
