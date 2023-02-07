import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/controllers/recommended_product_controller.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_column.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/icon_and_text_widget.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../start/widgets/app_text.dart';
import '../../utils/app_constants.dart';
import '../../widgets/app_icon.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(
      viewportFraction:
          0.85); // show next and previous slide page menu on hero section
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  var images = {
    "brocolli.png": "Vegetables",
    "orange.png": "Fruits",
    "milk.png": "Milks",
    "bread.png": "Breads"
  };

  @override
  void initState() {
    // to know the current page value
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[1];
    Get.find<PopularProductController>()
        .initProduct(product, Get.find<CartController>());

    String timeWidget(String date) {
      var outputDate = DateTime.now().toString();
      DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
      outputDate = outputFormat.format(inputDate);
      return outputDate;
    }


    return Column(
      children: [
        SizedBox(
          height: Dimensions.height20,
        ),

        // PROFILE BADGES START ================================================
        GetBuilder<UserController>(builder: (userController) {
          return userController.isLoading
              ? Container(
                  width: Dimensions.screenWidth,
                  height: Dimensions.height20 * 5,
                  margin: EdgeInsets.only(
                      left: Dimensions.width30, right: Dimensions.width30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 5),
                            blurRadius: 10,
                            color: Colors.grey[200]!)
                      ]),
                  child: Container(
                    padding: EdgeInsets.only(
                        left: Dimensions.width20, right: Dimensions.width20),
                    child: Row(children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("assets/image/profile_one.png"),
                        backgroundColor: AppColors.mainColor,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome!",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 18,
                                decoration: TextDecoration.none),
                          ),
                          SizedBox(
                            height: Dimensions.height10,
                          ),
                          Text(
                            userController.userModel!.name,
                            style: TextStyle(
                                color: Color(0xFF3b3f42),
                                fontSize: 18,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
                      Expanded(child: Container()),
                      Container(
                        width: Dimensions.width10 * 5,
                        height: Dimensions.height10 * 5,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFFe8e8e8),
                                  blurRadius: 5.0,
                                  offset: Offset(
                                      0, 5)
                                  ),
                            ],
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.mainColor),
                        // CART ICON START ====================================


                        child: GetBuilder<PopularProductController>(builder: (controller) {
                          return GestureDetector(
                            onTap: () {
                              if (controller.totalItems >= 0) {
                                Get.toNamed(RouteHelper.getCartPage());
                              }
                            },
                            child: Stack(
                              children: [
                                Center(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                                          color: AppColors.mainColor),
                                      child: Icon(
                                        CupertinoIcons.cart_fill,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )),
                                Get.find<PopularProductController>().totalItems >= 1
                                    ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: AppIcon(
                                    icon: Icons.circle,
                                    size: 20,
                                    iconColor: Colors.transparent,
                                    backgroundColor: const Color(0xFFfcf4e4),
                                  ),
                                )
                                    : Container(),

                                // TEXT IN CART ICON
                                Get.find<PopularProductController>().totalItems >= 1
                                    ? Positioned(
                                  right: 6,
                                  top: 3,
                                  child: BigText(
                                    text: Get.find<PopularProductController>()
                                        .totalItems
                                        .toString(),
                                    size: 12,
                                    color: const Color(0xFF756d54),
                                  ),
                                )
                                    : Container()
                              ],
                            ),
                          );
                        }),


                        // CART ICON END ====================================

                      ),
                    ]),
                  ),
                )
              : CustomLoader();
        }),
        // PROFILE BADGES END ==================================================

        SizedBox(
          height: Dimensions.height30,
        ),

        // SLIDER POPULAR CONTENT START ========================================
        // if want to get data, wrap using GetBuilder
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          // if false, akan muncul loading icon
          return popularProducts.isLoaded
              ? Container(
                  height: Dimensions.pageView,
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,

                      // position start from 0, connected with item Count
                      itemBuilder: (context, position) {
                        // called animation below _buildPageItem
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        }),
        // SLIDER POPULAR CONTENT END ==========================================

        // DOTS SLIDER START ===================================================
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        // DOTS SLIDER END ===================================================

        SizedBox(
          height: Dimensions.height30,
        ),

        // DISCOVER HEADING START ==============================================
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Discover"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3), // up the dot
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2), // up the text
                child: SmallText(text: "Product Type Offered"),
              )
            ],
          ),
        ),
        // DISCOVER HEADING END ==============================================

        SizedBox(
          height: Dimensions.height30,
        ),

        // PRODUCT TYPES START =================================================
        Container(
          height: Dimensions.height30 * 4,
          width: double.maxFinite,
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return Container(
                  margin: EdgeInsets.only(right: Dimensions.width30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // margin: const EdgeInsets.only(right: 10),
                        width: Dimensions.width20 * 4,
                        height: Dimensions.height20 * 4,

                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFFe8e8e8),
                                blurRadius: 5.0,
                                offset:
                                    Offset(0, 5) //\\ x no change, y is down 5px
                                ),
                          ],
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: Colors.white,
                          image: DecorationImage(
                              image: AssetImage("assets/image/" +
                                  images.keys.elementAt(index)),
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Container(
                        child: BigText(
                          size: Dimensions.font16,
                          text: images.values.elementAt(index),
                          color: AppColors.textColor,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        // PRODUCT TYPES END =================================================

        SizedBox(
          height: Dimensions.height10,
        ),

        // BADGE START ========================================================
        Container(
          height: Dimensions.width20 * 9,
          width: Dimensions.screenWidth,
          margin: EdgeInsets.only(
              left: Dimensions.width30,
              right: Dimensions.width30,
              bottom: Dimensions.height10),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: Dimensions.width20 * 6,
                margin: EdgeInsets.only(top: Dimensions.height30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          offset: Offset(-1, -5),
                          color: AppColors.mainColor.withOpacity(0.3))
                    ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    right: Dimensions.width30 * 6, bottom: Dimensions.height30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/figure_one.png"),
                  ),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: Dimensions.width20 * 5,
                margin: EdgeInsets.only(
                    left: Dimensions.width10 * 13,
                    top: Dimensions.height10 * 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Looking for Fresh Groceries?",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),
                    RichText(
                      text: TextSpan(
                          text: "You can get our recommendation \n",
                          style: TextStyle(
                              color: AppColors.iconColor2,
                              fontSize: Dimensions.font12),
                          children: [
                            TextSpan(text: "to get fresh groceries"),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // BADGE END ========================================================

        // RECOMMENDED HEADING START ==============================================
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            // text will be start from bottom line
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3), // up the dot
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2), // up the text
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        // RECOMMENDED HEADING END ==============================================

        // LIST RECOMMENDED FOOD BODY START ====================================
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // scrollable all body page
                  shrinkWrap: true,

                  // num of list food
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home"));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height10),
                        // margin untuk kiri gambar dan kanan text container
                        child: Row(
                          children: [
                            // IMAGE SECTION CONTAINER
                            Container(
                              // show the image
                              width: Dimensions.listViewImgSize,
                              height: Dimensions.listViewImgSize,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimensions.radius20),
                                color: Colors.white38,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          recommendedProduct
                                              .recommendedProductList[index]
                                              .img!),
                                ),
                              ),
                            ),

                            // TEXT TITLE SECTION CONTAINER
                            Expanded(
                              child: Container(
                                // container di dalam expanded akan mengambil semua available space
                                height: Dimensions.listViewTextContSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      right: Dimensions.width10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    // TITLE CONTENT
                                    children: [
                                      // FOOD TITLE
                                      BigText(
                                          text: recommendedProduct
                                              .recommendedProductList[index]
                                              .name!),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      // SmallText(text: "Safe for consumption."),
                                      Text(
                                        /*timeWidget( recommendedProduct
                                            .recommendedProductList[index].createdAt),*/
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .description!,
                                        maxLines: 1,
                                        // if more than 1 line, it will be ellipsis
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: const Color(0xFFccc7c5),
                                            fontSize: Dimensions.font12,
                                            height: 1.2),
                                      ),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        // give space between icon text in description box
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.circle_sharp,
                                              text: "Fresh",
                                              iconColor: AppColors.iconColor1),
                                          IconAndTextWidget(
                                              icon: Icons.price_change_sharp,
                                              text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .price!
                                                  .toString(),
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.favorite_outlined,
                                              text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .selected_people!
                                                  .toString(),
                                              iconColor: AppColors.iconColor2),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
        // LIST RECOMMENDED FOOD BODY END ====================================
      ],
    );
  }

  // POPULAR PRODUCTS START =====================================================
  Widget _buildPageItem(int index, ProductModel popularProduct) {
    // POPULAR IMAGE SLIDER ANIMATION ZOM IN-OUT START ===========================
    // dynamic scale the hero section when slider
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      //  current page scale
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      // to create transform scale while slider // mengecil ketika slider
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      // next page scale
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      // before page scale
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      // smooth the slider
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }
    // POPULAR SLIDER ANIMATION START ============================================

    // POPULAR PRODUCT IMAGE START =============================================
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              // give empty space between page menu in hero section
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color:
                    index.isEven ? const Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,

                  // IMAGE FOR BOX HERO SECTION (load from server)
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!),
                ),
              ),
            ),
          ),
          // POPULAR PRODUCT IMAGE START =============================================

          // HERO FOOD DESCRIPTION CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              // size margin of description box on hero section
              // position of description box
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,

                  // BADGE'S SHADOW
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        // x no change, y is down 5px
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),

              // BADGE START ===================================================
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15),

                // DESCRIPTION BADGE CONTENT START =====================================
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigText(
                      text: popularProduct.name!,
                      size: Dimensions.font26,
                    ),

                    SizedBox(
                      height: Dimensions.height10,
                    ),

                    // STARS & COMMENTS DESCRIPTION START ======================
                    Row(
                      children: [
                        // children takes list of children
                        // can put children one by one, or using list of children
                        Wrap(
                          // make the icon horizontally
                          children:
                              List.generate(popularProduct.stars!, (index) {
                            return Icon(
                              Icons.star,
                              color: AppColors.mainColor,
                              size: Dimensions.iconSize16,
                            );
                          }), // add icon stars
                        ),

                        SizedBox(
                          width: Dimensions.width10,
                        ),
                        SmallText(text: popularProduct.stars.toString()),

                        SizedBox(
                          width: Dimensions.width10 - 5,
                        ),
                        SmallText(text: "stars"),

                        SizedBox(
                          width: Dimensions.width10,
                        ),

                        SmallText(text: "34"),
                        SizedBox(
                          width: Dimensions.width10 - 5,
                        ),
                        SmallText(text: "comments"),
                      ],
                    ),

                    // STARS & COMMENTS DESCRIPTION END ======================

                    SizedBox(
                      height: Dimensions.height10,
                    ),

                    // ICON TAG START ==========================================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // give space between icon text in description box
                      children: [
                        IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "Fresh",
                            iconColor: AppColors.iconColor1),
                        IconAndTextWidget(
                            icon: Icons.price_change_sharp,
                            text: popularProduct.price.toString(),
                            iconColor: AppColors.mainColor),
                        IconAndTextWidget(
                            icon: Icons.favorite_outlined,
                            text: popularProduct.selected_people.toString(),
                            iconColor: AppColors.iconColor2),
                      ],
                    ),
                    // ICON TAG END ==========================================
                  ],
                ),
                // DESCRIPTION BADGE CONTENT END =====================================
              ),
              // BADGE END ===================================================
            ),
          ),
        ],
      ),
    );
  }
// POPULAR PRODUCTS END =====================================================

}
