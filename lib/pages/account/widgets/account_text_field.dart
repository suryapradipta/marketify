import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/colors.dart';
import '../../../utils/dimensions.dart';

class AccountTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  AccountTextField({Key? key,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimensions.height20, right: Dimensions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius15),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: Offset(1, 1),
              color: Colors.grey.withOpacity(0.2),
            )
          ]

      ),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: hintText,


          prefixIcon: Icon(icon, color: AppColors.yellowColor,),


          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,)),


          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              borderSide: BorderSide(
                width: 1.0,
                color: Colors.white,)),


          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius15)),

          hintStyle: TextStyle(color: Colors.black),

        ),
      ),
    );
  }
}
