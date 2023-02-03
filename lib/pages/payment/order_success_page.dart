import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketify/routes/route_helper.dart';
import 'package:marketify/utils/colors.dart';

import '../../base/custom_button.dart';
import '../../utils/dimensions.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;

  const OrderSuccessPage({required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(PaymentFailedDialog(orderID: orderID), barrierDismissible: false);
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle
                    : Icons.warning_amber_outlined,
                size: 150,
                color: AppColors.mainColor,
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              Text(
                status == 1
                    ? 'Thank you!'
                    : 'Sorry',
                style: TextStyle(fontSize: Dimensions.font26),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.height20,
                    vertical: Dimensions.height10),
                child: Text(
                  status == 1 ? 'Purchase was successful' : 'Purchase was failed',
                  style: TextStyle(
                      fontSize: Dimensions.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: Dimensions.height10,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.height20),
                child: CustomButton(
                    buttonText: 'Done',
                    fontSize: Dimensions.font20,
                    onPressed: () => Get.offAllNamed(RouteHelper.getInitial())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
