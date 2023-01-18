import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:marketify/base/show_custom_snakbar.dart';
import 'package:marketify/models/signup_body_model.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../base/custom_loader.dart';
import '../../controllers/auth_controller.dart';
import '../../utils/colors.dart';
import '../../widgets/app_text_field.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];

    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      // validation
      if(name.isEmpty) {
        showCustomSnackBar("Type in your name", title: "Name");
      }
      else if(phone.isEmpty) {
        showCustomSnackBar("Type in your phone number", title: "Phone Number");
      }
      else if(email.isEmpty) {
        showCustomSnackBar("Type in your email", title: "Email");
      }
      else if(!GetUtils.isEmail(email)) {
        showCustomSnackBar("Type in a valid email address", title: "Valid Email Address");
      }
      else if(password.isEmpty) {
        showCustomSnackBar("Type in your password", title: "Password");
      }
      else if(password.length<6) {
        showCustomSnackBar("Password can not be less than six characters", title: "Password");
      }
      else {
        SignUpBody signUpBody = SignUpBody(name: name,
            phone: phone,
            email: email,
            password: password);

        authController.registration(signUpBody).then((status) {
          if(status.isSuccess) {
            print("Success registration");
          }
          else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }


    return Scaffold(
      backgroundColor: Colors.white,

      // once sign up button is clicked, the page page will be hidden
        //based on registration method in auth_controller.dart
        // if _isloading true, the page will viewed, otherwise will be hidden
      body: GetBuilder<AuthController>(builder:(_authController){
        // single child scroll view and physics supaya ketika keyboard iphone muncul, tidak overflow alias error
        // if false show the form, otherwise show progress circular....
        return !_authController.isLoading?SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),


              // LOGO SECTION
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

              // NAME
              AppTextField(
                  textController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimensions.height20,),

              // PHONE NUMBER
              AppTextField(
                  textController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimensions.height20,),


              // SIGN UP BUTTON
              GestureDetector(
                onTap: (){
                  _registration(_authController);
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign up",
                      size: Dimensions.font20+Dimensions.font20/2,
                      color: Colors.white,),
                  ),
                ),
              ),

              SizedBox(height: Dimensions.height10,),

              // TAG LINE
              // supaya text bisa di pencet
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=()=>Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font20
                      )
                  )
              ),

              SizedBox(height: Dimensions.screenHeight*0.05,),

              // SIGN UP OPTION
              RichText(
                  text: TextSpan(
                      text: "Sign up using one of the following methods",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16
                      )
                  )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: Dimensions.radius30,
                    backgroundImage: AssetImage(
                        "assets/image/" + signUpImages[index]
                    ),
                  ),
                )),
              )




            ],
          ),
        ):const CustomLoader();
      })
    );
  }
}
