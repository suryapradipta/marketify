import 'package:flutter/material.dart';
import 'package:marketify/controllers/auth_controller.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/controllers/recommended_product_controller.dart';
import 'package:marketify/utils/app_constants.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/route_helper.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // HEADER SECTION
          // ICON HEADER SECTION
          Positioned(
              top: Dimensions.height20 * 3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // AppIcon(
                  //   icon: Icons.arrow_back_ios,
                  //   iconColor: Colors.white,
                  //   backgroundColor: AppColors.mainColor,
                  //   size: Dimensions.iconSize24,
                  // ),

                  // supaya home icon lebih ke kanan
                  SizedBox(width: Dimensions.width20*5,),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getInitial());

                    },
                    child: Container( //\\ Header - search button on the top right
                      width: Dimensions.height45,
                      height: Dimensions.height45,
                      child: Icon(
                        Icons.home_outlined,
                        color: Colors.white,
                        size: Dimensions.iconSize24,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),

                  // AppIcon(
                  //   icon: Icons.shopping_cart,
                  //   iconColor: Colors.white,
                  //   backgroundColor: AppColors.mainColor,
                  //   size: Dimensions.iconSize24,
                  // ),
                ],
              )),


          // BODY SECTION
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  // color: Colors.red,
                  // menghilangkan padding atas
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,


                    // menggunakan get builder, sekarang kita bisa mengakses controller
                    child: GetBuilder<CartController>(builder: (cartController){
                      var _cartList =cartController.getItems;
                      return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: (_, index){
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20*5,
                              child: Row(
                                children: [

                                  // IMAGE SECTION
                                  GestureDetector(
                                    // supaya bisa ke halaman makanan yang dipilih di cart
                                    onTap: (){
                                      var popularIndex = Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(_cartList[index].product!);
                                      if(popularIndex>=0) {
                                        Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                                      }else{
                                        var recommendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if(recommendedIndex<0){
                                          Get.snackbar(
                                              "History Product", "Product review is not available for history products!",
                                              backgroundColor: AppColors.mainColor, colorText: Colors.white);

                                        }else {
                                          Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cartpage"));

                                        }
                                      }
                                    },
                                    child: Container(
                                      width: Dimensions.height20*5,
                                      height: Dimensions.height20*5,
                                      margin: EdgeInsets.only(bottom: Dimensions.height10),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartController.getItems[index].img!
                                              )
                                          ),
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: Colors.white
                                      ),
                                    ),
                                  ),

                                  // ngasi jarak antara text dengan gambar
                                  SizedBox(width: Dimensions.width10,),


                                  // TEXT SECTION
                                  // takes all available space of parent container
                                  Expanded(child: Container(
                                    height: Dimensions.height20*5,
                                    child: Column(
                                      // want start from begining
                                      crossAxisAlignment: CrossAxisAlignment.start,

                                      // supaya ada vertical space atas bawah
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(text: cartController.getItems[index].name!, color: Colors.black54,),
                                        SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(text: "\$ "+ cartController.getItems[index].price.toString(), color: Colors.redAccent,),




                                            //=========COPYABLE=========
                                            Container(
                                              padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10, left: Dimensions.width10, right: Dimensions.width10),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white
                                              ),
                                              child: Row(
                                                children: [

                                                  // ICON ADD AND REMOVE FOOTBAR SECTION
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove, color: AppColors.signColor,)),
                                                  SizedBox(width: Dimensions.width10/2,),


                                                  // QUANTITY SECTION
                                                  BigText(text: _cartList[index].quantity.toString()),
                                                  SizedBox(width: Dimensions.width10/2,),
                                                  GestureDetector(
                                                      onTap: (){
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                        print("being tapped");

                                                      },
                                                      child: Icon(Icons.add, color: AppColors.signColor,))
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
                )):NoDataPage(text: "Your cart is empty!",);
          })
        ],
      ),



      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
        return Container(
          height: Dimensions.bottomHeightBar,
          padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius20*2),
                topRight:  Radius.circular(Dimensions.radius20*2),
              )
          ),
          child: cartController.getItems.length>0?Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white
                ),
                child: Row(
                  children: [




                    // PRICE SECTION
                    BigText(text: "\$ "+cartController.totalAmount.toString()),

                    SizedBox(width: Dimensions.width10/2,),
                  ],
                ),
              ),

              // PRICE AND ADD TO CART SECTION
              GestureDetector(
                onTap: () {
                  // popularProduct.addItem(product);

                  if(Get.find<AuthController>().userLoggedIn()) {
                    print("tapped");
                    cartController.addToHistory();
                  }
                  else {
                    Get.toNamed(RouteHelper.getSignInPage());
                  }

                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  child: BigText(text: "Check out", color: Colors.white,),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                ),
              )
            ],
          ):Container(),
        );
      }),
    );
  }
}
