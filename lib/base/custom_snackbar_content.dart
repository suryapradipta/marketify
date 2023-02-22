import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSnackBarContent extends StatelessWidget {
  const CustomSnackBarContent({Key? key, required this.errorText}) : super(key: key);

  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          height: 90,
          decoration: BoxDecoration(
            color: Color(0XFFC72C41),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Oh snap!",
                      style: TextStyle(
                          fontSize: 18, color: Colors.white),
                    ),
                    Spacer(),
                    Text(
                      errorText,
                      style: TextStyle(
                          fontSize: 12, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              "assets/image/bubbles.svg",
              height: 48,
              width: 40,
              color: Color(0xFF801336),
            ),
          ),
        ),
        Positioned(
          top: -20,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/image/fail.svg",
                height: 40,
              ),
              Positioned(
                top: 10,
                child: SvgPicture.asset(
                  "assets/image/close.svg",
                  height: 16,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
