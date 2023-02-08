import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketify/base/custom_app_bar.dart';
import 'package:marketify/base/custom_loader.dart';
import 'package:marketify/controllers/auth_controller.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:marketify/widgets/small_text.dart';

import '../../controllers/cart_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return Scaffold(
      // APP BAR START =========================================================
      appBar: CustomAppBar(title: "Profile", backButtonExist: false,),
      // APP BAR END =========================================================

      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    // make icon centered
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        // ICON PROFILE START ==================================
                        Container(
                          width: double.maxFinite,
                          height: Dimensions.height20 * 8,
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                              image: AssetImage("assets/image/profile_one.png"),
                            ),
                          ),
                        ),
                        // ICON PROFILE END ==================================

                        SizedBox(
                          height: Dimensions.height30,
                        ),

                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // NAME START ==================================
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.person_solid,
                                    backgroundColor: Colors.white,
                                    iconColor: AppColors.mainColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel!.name),
                                ),
                                // NAME END ==================================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // PHONE START =================================
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.phone_solid,
                                    backgroundColor: Colors.white,
                                    iconColor: AppColors.mainColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel!.phone),
                                ),
                                // PHONE END =================================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //EMAIL START =================================
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email_rounded,
                                    backgroundColor: Colors.white,
                                    iconColor: AppColors.mainColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel!.email),
                                ),
                                //EMAIL END =================================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // ADDRESS START ===============================
                                GetBuilder<LocationController>(
                                    builder: (locationController) {
                                  if (_userLoggedIn &&
                                      locationController.addressList.isEmpty) {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_pin,
                                          backgroundColor: Colors.white,
                                          iconColor: AppColors.mainColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 5,
                                        ),
                                        bigText:
                                            BigText(text: "Add your address"),
                                      ),
                                    );
                                  } else {
                                    return GestureDetector(
                                      onTap: () {
                                        Get.offNamed(
                                            RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidget(
                                          appIcon: AppIcon(
                                            icon: Icons.location_pin,
                                            backgroundColor: Colors.white,
                                            iconColor: AppColors.mainColor,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText:
                                              BigText(text: "Your address")),
                                    );
                                  }
                                }),
                                // ADDRESS END ===============================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                //MESSAGE START ================================
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.captions_bubble_fill,
                                    backgroundColor: Colors.white,
                                    iconColor: AppColors.mainColor,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Message"),
                                ),
                                //MESSAGE END ================================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // CUSTOMER SERVICE START ======================
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: CupertinoIcons.h,
                                    backgroundColor: Colors.white,
                                    iconColor: AppColors.iconColor1,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(text: "Customer Services"),
                                ),
                                // CUSTOMER SERVICE END ======================

                                SizedBox(
                                  height: Dimensions.height20,
                                ),

                                // SIGN OUT START =============================
                                GestureDetector(
                                  onTap: () {
                                    // clear all information while signed out
                                    if (Get.find<AuthController>()
                                        .userLoggedIn()) {
                                      Get.find<AuthController>()
                                          .clearSharedData();
                                      Get.find<CartController>().clear();
                                      Get.find<CartController>()
                                          .clearCartHistory();

                                      Get.find<LocationController>()
                                          .clearAddressList();

                                      Get.offNamed(RouteHelper.getSignInPage());
                                    } else {
                                      "you log out";
                                    }
                                  },
                                  child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout,
                                      backgroundColor: Colors.white,
                                      iconColor: Colors.redAccent,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Sign Out"),
                                  ),
                                ),
                                // SIGN OUT END =============================


                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : CustomLoader())
            : GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getSignInPage());
                },
                child: Container(
                    child: Center(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      height: MediaQuery.of(context).size.height * 0.44,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        image: DecorationImage(
                          image: AssetImage("assets/image/hello.png"),
                        ),
                      ),
                    ),

                    SmallText(text: "Come be a part of our mission", size: Dimensions.font20,),
                    SizedBox(height: Dimensions.height20),

                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 4,
                      margin: EdgeInsets.only(
                          left: Dimensions.width20, right: Dimensions.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                      ),
                      child: Center(
                          child: BigText(
                        text: "Sign In",
                        color: Colors.white,
                        size: Dimensions.font26,
                      )),
                    )
                  ],
                ))),
              );
      }),
    );
  }
}
