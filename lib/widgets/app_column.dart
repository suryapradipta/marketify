import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketify/widgets/small_text.dart';

import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;

  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, //\\ to make all element in border description page start from beginning
      children: [
        BigText(text: text, size: Dimensions.font26,),
        SizedBox(height: Dimensions.height10,), //\\ space between title and the bottom of title
        // comment section
        Row(
          children: [ //\\ children takes list of children //\\ can put children one by one, or using list of children
            Wrap( //\\ make the icon horizontally
              children: List.generate(5, (index) {return Icon(Icons.star, color: AppColors.mainColor, size: 15,);}), //\\ add icon stars
            ),
            SizedBox(width: 10,),
            SmallText(text: "4.5"),
            SizedBox(width: 10,),
            SmallText(text: "1287"),
            SizedBox(width: 10,),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(height: Dimensions.height10,),
        // time and distance
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //\\ give space between icon text in description box
          children: [
            IconAndTextWidget(icon: Icons.circle_sharp,
                text: "Normal",

                iconColor: AppColors.iconColor1),
            IconAndTextWidget(icon: Icons.location_on,
                text: "1.7km",

                iconColor: AppColors.mainColor),
            IconAndTextWidget(icon: Icons.access_time_rounded,
                text: "32min",

                iconColor: AppColors.iconColor2)
          ],
        )
      ],
    );
  }
}
