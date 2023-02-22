import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketify/pages/auth/sign_up_page.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loader.dart';
import '../../base/show_custom_snakbar.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if(phone.isEmpty) {
        showCustomSnackBar("Type in your phone", title: "Phone");
      }
      else if(password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      }
      else if(password.length<6) {
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }
      else {
        authController.login(phone, password).then((status) {
          if(status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
            // Get.toNamed(RouteHelper.getCartPage());
          }
          else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,
      // single child scroll view and physics supaya ketika keyboard iphone muncul, tidak overflow alias error
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),


              // APP LOGO
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: Image.asset("assets/image/shopping_store.png",
                    height: MediaQuery.of(context).size.height*0.33,
                    width: MediaQuery.of(context).size.width*0.33,),
                  /*child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part 1.png"
                    ),
                  ),*/
                ),
              ),


              // WELCOME SECTION
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      "Sign in to continue.",
                      style: TextStyle(
                        fontSize: Dimensions.font20,
                        // fontWeight: FontWeight.bold
                        color: Colors.grey[500],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: Dimensions.height20,),


              // PHONE
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),

              // PASSWORD
              AppTextField(
                  textController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_sharp, isObscure: true),
              SizedBox(height: Dimensions.height20,),


              SizedBox(height: Dimensions.height20,),

              // TAG LINE
              /*Row(
                children: [
                  // supaya text nya ke kanan
                  Expanded(child: Container()),
                  *//*RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20
                          )
                      )
                  ),*//*
                  SizedBox(width: Dimensions.width20,)
                ],
              ),*/

              SizedBox(height: Dimensions.screenHeight*0.03,),

              // SIGN IN BUTTON
              GestureDetector(
                onTap: (){
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),


              // SIGN UP OPTION
              RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(), transition: Transition.fade),
                            text: "Create",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimensions.font20
                            )),
                      ]
                  )
              ),




            ],
          ),
        ):CustomLoader();
      })
    );
  }
}
