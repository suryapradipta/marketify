import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marketify/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/search_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../utils/expanded_widget.dart';
import '../../utils/styles.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/text_widget.dart';

class SearchResultWidget extends StatefulWidget {
  final String searchText;

  SearchResultWidget({required this.searchText});

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    // _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
  }

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

    return Container(
      height: 500,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GetBuilder<SearchProductController>(builder: (searchController) {
          bool _isNull = true;
          int _length = 0;

          _isNull = searchController.searchProductList == null;
          if (!_isNull) {
            _length = searchController.searchProductList!.length;
          }

          return _isNull
              ? SizedBox()
              // TEXT FOUND START ==================================================
              : Center(
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: Padding(
                      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
                      child: Row(children: [
                        Text(
                          _length.toString(),
                          style: robotoBold.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                        SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Text(
                          'results found',
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).disabledColor,
                              fontSize: Dimensions.fontSizeSmall),
                        ),
                      ]),
                    ),
                  ),
                );
          // TEXT FOUND END ==================================================
        }),
        Expanded(
            child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollEndNotification) {
              Get.find<SearchProductController>().searchData(widget.searchText);
            }
            return false;
          },
          child: Container(
            child: GetBuilder<SearchProductController>(
                builder: (searchController) {
              return InkWell(
                onTap: () {},
                child: SingleChildScrollView(
                  child: Center(
                      child: SizedBox(
                          width: Dimensions.WEB_MAX_WIDTH,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: Dimensions.padding10),
                            itemCount:
                                searchController.searchProductList?.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  onTap: () {
                                    bool found = false;
                                    String page = "initial";
                                    late List tempList = [];
                                    int productIndex = 0;
                                    tempList =
                                        Get.find<PopularProductController>()
                                            .popularProductList;
                                    tempList.forEach((element) {
                                      if (element.id.toString() ==
                                          searchController
                                              .searchProductList?[index].id
                                              .toString()) {
                                        found = true;
                                        productIndex++;
                                        page = "popular";
                                      } else {
                                        productIndex++;
                                      }
                                    });
                                    if (found == false) {
                                      productIndex = 0;
                                      tempList = [];
                                      tempList =
                                          Get.find<PopularProductController>()
                                              .popularProductList;
                                      tempList.forEach((element) {
                                        if (element.id.toString() ==
                                            searchController
                                                .searchProductList?[index].id
                                                .toString()) {
                                          found = true;
                                          page = "recommended";
                                          productIndex++;
                                        } else {
                                          productIndex++;
                                        }
                                      });
                                    }

                                    var product = searchController
                                        .searchProductList![index];
                                    Get.find<PopularProductController>()
                                        .initProduct(product,
                                            Get.find<CartController>());
                                    showModalBottomSheet(
                                        context: context,
                                        // backgroundColor: Colors.white,
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        builder: (_) {

                                          // FOOD DETAIL START =================
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
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
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(

                                                      margin: EdgeInsets.all(
                                                          Dimensions.height10),
                                                      width:
                                                          Dimensions.width20 *
                                                              2,
                                                      height:
                                                          Dimensions.height20 *
                                                              2,
                                                      decoration: BoxDecoration(

                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius20),
                                                        color: Colors.white70,
                                                      ),

                                                      // ARROW BACK ICON START ========
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          // Get.toNamed(RouteHelper.getInitialRoute());
                                                          Get.back();
                                                        },
                                                        child: Center(
                                                            child: Icon(
                                                          Icons.arrow_back_ios,
                                                          size: Dimensions
                                                                  .iconSize16 +
                                                              4,
                                                          color: Colors.black54,
                                                        )),
                                                      ),

                                                      // ARROW BACK ICON END ========
                                                    ),

                                                    // CART ICON START ========
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.toNamed(RouteHelper
                                                            .getCartPage(
                                                                productIndex,
                                                                page));
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.all(
                                                            Dimensions
                                                                .height10),
                                                        width:
                                                            Dimensions.width20 *
                                                                2,
                                                        height: Dimensions
                                                                .height20 *
                                                            2,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  Dimensions
                                                                      .radius20),
                                                          color: Colors.white70,
                                                        ),
                                                        child: GetBuilder<
                                                                CartController>(
                                                            builder: (_) {
                                                          return Stack(
                                                            children: [
                                                              const Positioned(
                                                                child: Center(
                                                                    child: Icon(
                                                                  Icons
                                                                      .shopping_cart_outlined,
                                                                  size: 22,
                                                                  color: Colors
                                                                      .black54,
                                                                )),
                                                              ),
                                                              Get.find<CartController>()
                                                                          .totalItems >=
                                                                      1
                                                                  ? Positioned(
                                                                      right: 0,
                                                                      top: 0,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .circle,
                                                                          size:
                                                                              20,
                                                                          color:
                                                                              AppColors.mainColor,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(),

                                                              if (Get.find<CartController>()
                                                                          .totalItems >
                                                                      1 &&
                                                                  Get.find<CartController>()
                                                                          .totalItems <
                                                                      10)
                                                                Positioned(
                                                                  right: 5,
                                                                  top: 3,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    Get.find<
                                                                            CartController>()
                                                                        .totalItems
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .font12,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                                )
                                                              else if (Get.find<
                                                                          CartController>()
                                                                      .totalItems >=
                                                                  10)
                                                                Positioned(
                                                                  right: 4,
                                                                  top: 3,
                                                                  child: Center(
                                                                      child:
                                                                          Text(
                                                                    Get.find<
                                                                            CartController>()
                                                                        .totalItems
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            Dimensions
                                                                                .font12,
                                                                        color: Colors
                                                                            .white),
                                                                  )),
                                                                )
                                                              else
                                                                Container()
                                                            ],
                                                          );
                                                        }),
                                                      ),
                                                    )
                                                    // CART ICON END ========
                                                  ],
                                                ),

                                                Container(
                                                  height: 430,
                                                  padding: EdgeInsets.only(
                                                      left: Dimensions.width20,
                                                      right: Dimensions.width20,
                                                      top: Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(
                                                          topRight:
                                                              Radius.circular(
                                                                  Dimensions
                                                                      .padding20),
                                                          topLeft: Radius
                                                              .circular(Dimensions
                                                                  .padding20))),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      BigText(
                                                          size:
                                                              Dimensions.font26,
                                                          text: product.name
                                                              .toString(),
                                                          color:
                                                              Colors.black87),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .padding10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Wrap(
                                                            children: List.generate(
                                                                product.stars!,
                                                                (index) => Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .mainColor,
                                                                    size: 15)),
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .width10,
                                                          ),
                                                          TextWidget(
                                                              text: "(" +
                                                                  product.stars!
                                                                      .toString() +
                                                                  ") stars",
                                                              color: const Color(
                                                                  0xFFccc7c5)),
                                                          SizedBox(
                                                            width: Dimensions
                                                                .width20,
                                                          ),
                                                          Icon(
                                                            Icons.date_range,
                                                            color: AppColors
                                                                .mainColor,
                                                            size: 15,
                                                          ),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 -
                                                                5,
                                                          ),
                                                          SmallText(
                                                              text: timeWidget(
                                                                  product
                                                                      .createdAt
                                                                      .toString())),
                                                          SizedBox(
                                                            width: Dimensions
                                                                    .width10 -
                                                                5,
                                                          ),
                                                          SmallText(
                                                              text: " offered")
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .padding20,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // ITEM VIEW ========
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .circle_sharp,
                                                              text: "Fresh",
                                                              iconColor: AppColors
                                                                  .iconColor1),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .location_on,
                                                              text: product
                                                                  .location
                                                                  .toString(),
                                                              iconColor: AppColors
                                                                  .mainColor),
                                                          IconAndTextWidget(
                                                              icon: Icons
                                                                  .favorite_outlined,
                                                              text: "(" +
                                                                  product
                                                                      .selected_people
                                                                      .toString() +
                                                                  ") selected people",
                                                              iconColor: AppColors
                                                                  .iconColor2),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .padding20,
                                                      ),
                                                      BigText(
                                                          size: 22,
                                                          text: "Introduce",
                                                          color: AppColors
                                                              .titleColor),
                                                      SizedBox(
                                                        height: Dimensions
                                                            .padding20,
                                                      ),
                                                      Expanded(
                                                        child:
                                                            SingleChildScrollView(
                                                          child: DescriptionTextWidget(
                                                              text: product
                                                                  .description
                                                                  .toString()),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: Dimensions
                                                          .detailFoodImgPad,
                                                      right: Dimensions
                                                          .detailFoodImgPad),
                                                  height: Dimensions
                                                      .buttonButtonCon,
                                                  padding: EdgeInsets.only(
                                                      top: Dimensions.padding30,
                                                      bottom:
                                                          Dimensions.padding30,
                                                      left: 20,
                                                      right: 20),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.all(
                                                            Dimensions
                                                                .padding20),
                                                        child: Row(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.find<
                                                                        PopularProductController>()
                                                                    .setQuantity(
                                                                        false);
                                                              },
                                                              child: Icon(
                                                                  Icons.remove,
                                                                  color: AppColors
                                                                      .signColor),
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .padding10),
                                                            GetBuilder<
                                                                PopularProductController>(
                                                              builder: (_) {
                                                                return BigText(
                                                                    text: Get.find<
                                                                            PopularProductController>()
                                                                        .inCartItems
                                                                        .toString(),
                                                                    color: AppColors
                                                                        .mainBlackColor);
                                                              },
                                                            ),
                                                            SizedBox(
                                                                width: Dimensions
                                                                    .padding10),
                                                            GestureDetector(
                                                              onTap: () {
                                                                Get.find<
                                                                        PopularProductController>()
                                                                    .setQuantity(
                                                                        true);
                                                              },
                                                              child: Icon(
                                                                  Icons.add,
                                                                  color: AppColors
                                                                      .signColor),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    Dimensions
                                                                        .padding20),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  offset:
                                                                      Offset(
                                                                          0, 0),
                                                                  blurRadius:
                                                                      10,
                                                                  //spreadRadius: 3,
                                                                  color: AppColors
                                                                      .titleColor
                                                                      .withOpacity(
                                                                          0.05))
                                                            ]),
                                                      ),
                                                      Expanded(
                                                          child: Container()),
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.find<
                                                                  PopularProductController>()
                                                              .addItem(product);
                                                        },
                                                        child: Container(
                                                          child: BigText(
                                                            size: 20,
                                                            text: "\$" +
                                                                (product.price)
                                                                    .toString() +
                                                                " | " +
                                                                "Add to Cart",
                                                            color: Colors.white,
                                                          ),
                                                          padding: EdgeInsets
                                                              .all(Dimensions
                                                                  .padding20),
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .mainColor,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Dimensions
                                                                          .padding20),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            5),
                                                                    blurRadius:
                                                                        10,
                                                                    //spreadRadius: 3,
                                                                    color: AppColors
                                                                        .mainColor
                                                                        .withOpacity(
                                                                            0.3))
                                                              ]),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .buttonBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                                Dimensions
                                                                    .padding40),
                                                        topRight:
                                                            Radius.circular(
                                                                Dimensions
                                                                    .padding40),
                                                      )),
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: Dimensions.appMargin,
                                        right: Dimensions.appMargin,
                                        bottom: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // PRODUCT IMAGE START =========================
                                        Container(
                                          width: Dimensions.listViewImg,
                                          height: Dimensions.listViewImg,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.padding20),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(AppConstants
                                                          .UPLOADS_URL +
                                                      searchController
                                                          .searchProductList![
                                                              index]
                                                          .img
                                                          .toString()))),
                                        ),
                                        // PRODUCT IMAGE END =========================

                                        Expanded(
                                          child: Container(
                                            padding: Dimensions.isWeb
                                                ? EdgeInsets.only(
                                                    left: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                    right: Dimensions
                                                        .PADDING_SIZE_SMALL)
                                                : EdgeInsets.all(0),
                                            height: Dimensions.listViewCon,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius.circular(
                                                        Dimensions.padding20),
                                                    bottomRight:
                                                        Radius.circular(
                                                            Dimensions
                                                                .padding20))),
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: Dimensions.padding10,
                                                  right: Dimensions.padding10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  BigText(
                                                      text: searchController
                                                          .searchProductList![
                                                              index]
                                                          .name
                                                          .toString(),
                                                      /* element.value,*/
                                                      color: Colors.black87),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.padding10,
                                                  ),
                                                  Text(
                                                    searchController
                                                        .searchProductList![
                                                            index]
                                                        .description
                                                        .toString(),
                                                    maxLines: 1,
                                                    // if more than 1 line, it will be ellipsis
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        color: const Color(
                                                            0xFFccc7c5),
                                                        fontSize:
                                                            Dimensions.font12,
                                                        height: 1.2),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        Dimensions.padding10,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      IconAndTextWidget(
                                                          icon: Icons
                                                              .circle_sharp,
                                                          text: "Fresh",
                                                          iconColor: AppColors
                                                              .iconColor1),
                                                      IconAndTextWidget(
                                                          icon: Icons
                                                              .price_change_sharp,
                                                          text: searchController
                                                              .searchProductList![
                                                                  index]
                                                              .price
                                                              .toString(),
                                                          iconColor: AppColors
                                                              .mainColor),
                                                      IconAndTextWidget(
                                                          icon: Icons
                                                              .favorite_outlined,
                                                          text: searchController
                                                              .searchProductList![
                                                                  index]
                                                              .selected_people
                                                              .toString(),
                                                          iconColor: AppColors
                                                              .iconColor2),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ))),
                ),
              );
            }),
          ),
        )),
      ]),
    );
  }
}
