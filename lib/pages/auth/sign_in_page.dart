import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketify/pages/auth/sign_up_page.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();



    return Scaffold(
      backgroundColor: Colors.white,
      // single child scroll view and physics supaya ketika keyboard iphone muncul, tidak overflow alias error
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.05,),


            // APP LOGO
            Container(
              height: Dimensions.screenHeight*0.25,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                      "assets/image/logo part 1.png"
                  ),
                ),
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
                    "Sign into your account",
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


            // EMAIL
            AppTextField(
                textController: emailController,
                hintText: "Email",
                icon: Icons.email),
            SizedBox(height: Dimensions.height20,),

            // PASSWORD
            AppTextField(
                textController: passwordController,
                hintText: "Password",
                icon: Icons.password_sharp),
            SizedBox(height: Dimensions.height20,),


            SizedBox(height: Dimensions.height20,),

            // TAG LINE
            Row(
              children: [
                // supaya text nya ke kanan
                Expanded(child: Container()),
                RichText(
                    text: TextSpan(
                        text: "Sign into your account",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20
                        )
                    )
                ),
                SizedBox(width: Dimensions.width20,)
              ],
            ),

            SizedBox(height: Dimensions.screenHeight*0.05,),

            // SIGN IN BUTTON
            Container(
              width: Dimensions.screenWidth/2,
              height: Dimensions.screenHeight/13,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor
              ),
              child: Center(
                child: BigText(
                  text: "Sign in",
                  size: Dimensions.font20+Dimensions.font20/2,
                  color: Colors.white,),
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
      ),
    );
  }
}
