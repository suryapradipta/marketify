import 'package:flutter/cupertino.dart';
import 'package:marketify/utils/dimensions.dart';

class BigText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
  BigText({Key? key, this.color = const Color(0xFF332d2b),
    required this.text,
    this.size = 0, //\\ text size
    this.overFlow = TextOverflow.ellipsis //\\ if the text is long, so it will be dot (...) called ellipsis. ellipsis can change in the future
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1, //\\ if more than 1 line, it will be ellipsis
      overflow: overFlow,
      style: TextStyle(
          fontFamily: 'Roboto',
          color: color,
          fontSize: size==0?Dimensions.font20:size,
          fontWeight: FontWeight.w400
      ),
    );
  }
}
