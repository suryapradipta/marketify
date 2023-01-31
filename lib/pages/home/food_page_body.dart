import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:marketify/controllers/popular_product_controller.dart';
import 'package:marketify/controllers/recommended_product_controller.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_column.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/icon_and_text_widget.dart';
import 'package:marketify/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';

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
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Column(
      children: [
        SizedBox(
          height: Dimensions.height20,
        ),

        GetBuilder<UserController>(builder: (userController) {
          return Container(
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
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/image/profile1.png"),
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
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: AppColors.mainColor),
                    child: Center(
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: Dimensions.iconSize24,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.height30,
        ),

        // SLIDER POPULAR FOOD CONTAINER SECTION
        // if want to get data, wrap using GetBuilder
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          // if false, akan muncul loading icon
          return popularProducts.isLoaded
              ? Container(
                  // color: Colors.red,
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

        // DOTS SLIDER SECTION
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

        // LIST RECOMMENDED TITLE SECTION
        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          // popular text
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

        // RECOMMENDED FOOD

        // LIST RECOMMENDED FOOD BODY SECTION
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // scrollable all body page
                  shrinkWrap: true,

                  // jumlah list food
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
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          // ! means not to be null
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              recommendedProduct
                                                  .recommendedProductList[index]
                                                  .img!))),
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
                                      SmallText(
                                          text: "With chinese characteristics"),
                                      SizedBox(
                                        height: Dimensions.height10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        //\\ give space between icon text in description box
                                        children: [
                                          IconAndTextWidget(
                                              icon: Icons.price_check,
                                              text: recommendedProduct
                                                  .recommendedProductList[index]
                                                  .price!
                                                  .toString(),
                                              iconColor: AppColors.iconColor1),
                                          /*IconAndTextWidget(icon: Icons.price_change,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),*/
                                          IconAndTextWidget(
                                              icon: Icons.location_on,
                                              text: "1.7km",
                                              iconColor: AppColors.mainColor),
                                          IconAndTextWidget(
                                              icon: Icons.access_time_rounded,
                                              text: "32min",
                                              iconColor: AppColors.iconColor2)
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
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    // ANIMATION ZOOM IN-OUT IMAGE SLIDER HERO SECTION
    Matrix4 matrix =
        new Matrix4.identity(); //\\ dynamic scale the hero section when slider
    if (index == _currPageValue.floor()) {
      //\\  current page scale
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height *
          (1 - currScale) /
          2; //\\ to create transform scale while slider //\\ mengecil ketika slider
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      //\\ next page scale
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      //\\ before page scale
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      //\\smooth the slider
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          // SLIDER POPULAR FOOD CONTENT SECTION

          // "GestureDetector-onTap" supaya bisa di pencet
          GestureDetector(
            onTap: () {
              // beralih halaman
              Get.toNamed(RouteHelper.getPopularFood(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              //\\ give empty space between page menu in hero section
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,

                      // IMAGE FOR BOX HERO SECTION (load from server)
                      image: NetworkImage(
                          // ! means not to be null
                          AppConstants.BASE_URL +
                              AppConstants.UPLOAD_URL +
                              popularProduct.img!))),
            ),
          ),

          // HERO FOOD DESCRIPTION CONTAINER
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              // size margin of description box on hero section // position of description box
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,

                  // BORDER SHADOW DESCRIPTION SECTION
                  boxShadow: [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5) //\\ x no change, y is down 5px
                        ),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0))
                  ]),

              // TITLE DESCRIPTION SECTION
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, right: 15),

                // DESCRIPTION CONTENT FROM AppColumn.dart
                // ! means name is not empty
                child: AppColumn(text: popularProduct.name!),
              ),
            ),
          )
        ],
      ),
    );
  }
}
