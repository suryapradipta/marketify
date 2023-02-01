import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketify/base/custom_loader.dart';
import 'package:marketify/controllers/auth_controller.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';

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
      // APP BAR HEADER SECTION
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Profile",
          size: 24,
          color: Colors.white,
        ),
      ),

      // ICON IMAGE SECTION
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    // supaya icon di tengah
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.height20),
                    child: Column(
                      children: [
                        // PROFILE ICON
                        AppIcon(
                          icon: Icons.person_rounded,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.height45 + Dimensions.height30,
                          size: Dimensions.height15 * 10,
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // NAME ICON
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person_rounded,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel!.name)),

                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),

                                // PHONE
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone_iphone,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel!.phone)),

                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),

                                //EMAIL
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.email_rounded,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel!.email),
                                ),

                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),

                                // ADDRESS
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
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
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
                                            backgroundColor:
                                                AppColors.mainColor,
                                            iconColor: Colors.white,
                                            iconSize:
                                                Dimensions.height10 * 5 / 2,
                                            size: Dimensions.height10 * 5,
                                          ),
                                          bigText:
                                              BigText(text: "Your address")),
                                    );
                                  }
                                }),


                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),
                                //Message
                                AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.message,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimensions.height10 * 5 / 2,
                                    size: Dimensions.height10 * 5,
                                  ),
                                  bigText: BigText(
                                      text: "Message"),
                                ),

                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),

                                SizedBox(
                                  height: Dimensions.height30,
                                ),

                                // MESSAGE
                                AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.help_outline,
                                      backgroundColor: Colors.redAccent,
                                      iconColor: Colors.white,
                                      iconSize: Dimensions.height10 * 5 / 2,
                                      size: Dimensions.height10 * 5,
                                    ),
                                    bigText: BigText(text: "Customer Services")),
                                SizedBox(
                                  height: Dimensions.height10 / 2,
                                ),

                                // SIGN OUT START
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
                                        backgroundColor: Colors.redAccent,
                                        iconColor: Colors.white,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 5,
                                      ),
                                      bigText: BigText(text: "Sign Out")),
                                ),
                                SizedBox(
                                  height: Dimensions.height10,
                                ),
                                // SIGN OUT END
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
                        width: double.maxFinite,
                        height: Dimensions.height20 * 8,
                        margin: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/image/signintocontinue.png")))),
                    Container(
                      width: double.maxFinite,
                      height: Dimensions.height20 * 5,
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
