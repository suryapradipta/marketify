import 'package:flutter/material.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/controllers/recommended_product_controller.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_constants.dart';
import '../cart/cart_page.dart';

// Membuat page yang ketika di scroll, halamannya mengikuti scrollnya
class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      // supaya background TEXT SECTION jadi putih
      backgroundColor: Colors.white,
      body: CustomScrollView(
        // special widget that has special effect when scrolling
        slivers: [

          // CREATE IMAGE SECTION
          SliverAppBar(
            // menghilangkan icon back (bug)
            automaticallyImplyLeading: false,

            // supaya ketika di scroll/expandable, icon tidak kepotong
            toolbarHeight: 70,

            // CREATE ICON ON IMAGE SECTION
            title: Row(
              // supaya icon mengisi bagian pojok kiri dan pojok kanan
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    if(page=="cartpage"){
                      Get.toNamed(RouteHelper.getCartPage());
                    }else{
                      Get.toNamed(RouteHelper.getInitial());
                    }
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                // AppIcon(icon: Icons.shopping_cart_outlined)
                GetBuilder<PopularProductController>(builder: (controller){
                  return GestureDetector(
                    onTap: (){
                      if(controller.totalItems>=0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 0, top: 0,

                            child: AppIcon(icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,),
                        ):
                        Container(),


                        // TEXT IN CART ICON
                        Get.find<PopularProductController>().totalItems>=1?
                        Positioned(
                          right: 3, top: 3,
                          child: BigText(
                            text: Get.find<PopularProductController>().totalItems.toString(),
                            size: 12,
                            color: Colors.white,

                          ),
                        ):
                        Container()
                      ],
                    ),
                  );
                })
              ],
            ),


            // TITLE SECTION
            bottom: PreferredSize(
              // tinggi setelah image di scroll
              preferredSize: Size.fromHeight(20),
              child: Container(
                // center widget supaya title di tengah
                child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                // supaya widthnya ngambil seluruh bagian ke kanan dan ke kiri
                width: double.maxFinite,
                // ngasi padding untuk title
                padding: EdgeInsets.only(top: 5, bottom: 10),



                // CREATE RADIUS ON TEXT SECTION
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20),
                        topRight: Radius.circular(Dimensions.radius20)
                  )
                ),
              ),
            ),
            // ngasi batasan ketika di scroll
            pinned: true,
            // ketika di scroll warna gambar menjadi kuning
            backgroundColor: AppColors.yellowColor,
            // tinggi gambar menjadi 300 dan bisa di expand atau scroll keatas
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(

              // IMAGE SECTION CONTENT
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,

                // supaya ukuran gambarnya full
                fit: BoxFit.cover,
              ),
            ),
          ),






          // CREATE DESCRIPTION TEXT SECTION BELOW IMAGE SECTION
          SliverToBoxAdapter(
            child: Column(
              children: [
                // add container to apply margin
                Container(

                  // DESCRIPTION CONTENT
                  // supaya ketika textnya panjang ada icon "show more"
                  child: ExpandableTextWidget(text: product.description!),
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                )
              ],
            ),
          )
        ],
      ),
      // pakai column karena ada dua bagian atas dan bawah di bagian footer navigation bar, yaitu: amount section dan add to cart section





      // BOTTOM NAVIGATION BAR SECTION
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          // supaya column berada di bagian bawah
          mainAxisSize: MainAxisSize.min,
          children: [


            // ICON SECTION
            // wrap container untuk nambahin padding
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10,
              ),
              child: Row(
                // supaya icon berada di pojok kiri dan kanan
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  // REMOVE ICON
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white ,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove),
                  ),



                  // PRICE SECTION
                  BigText(text: "\$ ${product.price!} X ${controller.inCartItems} ", color: AppColors.mainBlackColor, size: Dimensions.font26,),

                  // ADD ICON
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(
                        iconSize: Dimensions.iconSize24,
                        iconColor: Colors.white ,
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.add),
                  )
                ],
              ),
            ),


            // ADD TO CART SECTION
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight:  Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white
                    ),

                    // FAVORITE ICON
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),

                  // ADD TO CART SECTION
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20, left: Dimensions.width20, right: Dimensions.width20),
                      child: BigText(text: "\$ ${product.price!} | Add to cart", color: Colors.white,),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
