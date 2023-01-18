import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketify/utils/colors.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/app_icon.dart';
import 'package:marketify/widgets/big_text.dart';

import '../../widgets/account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        body: Container(
          // supaya icon di tengah
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimensions.height20),
          child: Column(

            children: [

              // PROFILE ICON
              AppIcon(
                icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimensions.height45 + Dimensions.height30,
                size: Dimensions.height15 * 10,),
              SizedBox(height: Dimensions.height30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      // NAME ICON
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Surya")),
                      SizedBox(height: Dimensions.height20,),

                      // PHONE
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.phone,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "+6281246038181")),
                      SizedBox(height: Dimensions.height20,),

                      //EMAIL
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.email,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "suryapradipta.my@gmail.com")),
                      SizedBox(height: Dimensions.height20,),

                      // ADDRESS
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.location_on,
                            backgroundColor: AppColors.yellowColor,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Fill your address")),
                      SizedBox(height: Dimensions.height20,),

                      // MESSAGE
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Messages")),
                      SizedBox(height: Dimensions.height20,),

                      // MESSAGE
                      AccountWidget(
                          appIcon: AppIcon(
                            icon: Icons.message_outlined,
                            backgroundColor: Colors.redAccent,
                            iconColor: Colors.white,
                            iconSize:Dimensions.height10*5/2 ,
                            size: Dimensions.height10*5,),
                          bigText: BigText(text: "Messages")),
                      SizedBox(height: Dimensions.height20,),
                    ],
                  ),
                ),
              )

            ],
          ),
        )
    );
  }
}
