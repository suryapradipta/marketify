import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketify/utils/dimensions.dart';
import 'package:marketify/widgets/small_text.dart';

import '../utils/colors.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color iconColor;

  const IconAndTextWidget(
      {Key? key,
      required this.icon,
      required this.text,
      required this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.only(top: 3, bottom: 3, left: 5, right: 5),
          decoration: BoxDecoration(
              color: Colors.white,
            borderRadius:
            BorderRadius.circular(
                Dimensions.radius15),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 10,
                    color: Colors.grey[200]!)
              ]
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: Dimensions.iconSize24,
              ),
              SizedBox(
                width: 3,
              ),
              SmallText(
                text: text,
              ),
            ],
          ),
        ),

      ],
    );
  }
}
