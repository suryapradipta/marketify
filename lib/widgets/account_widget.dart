import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketify/utils/dimensions.dart';

import 'app_icon.dart';
import 'big_text.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key, required this.appIcon, required this.bigText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),

      padding: EdgeInsets.only(
          left: Dimensions.width10,
          top: Dimensions.width10,
          bottom: Dimensions.width10),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimensions.width20,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
        borderRadius: BorderRadius.circular(Dimensions.radius15),

          boxShadow: [
          BoxShadow(
            color: Colors.grey[200]!,
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ]
      ),
    );
  }
}
