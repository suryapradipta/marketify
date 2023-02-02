import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketify/utils/dimensions.dart';

import '../../controllers/order_controller.dart';
import '../../utils/styles.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions(
      {Key? key,
      required this.value,
      required this.title,
      required this.amount,
      required this.isFree})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String ? value) => orderController.setDeliveryType(value!),
            activeColor: Theme.of(context).primaryColor,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            title,
            style: robotoRegular,
          ),
          SizedBox(
            width: Dimensions.width10 / 2,
          ),
          Text(
            '(${(value == 'picked up' || isFree) ? 'free' : '\$${amount / 10}'})',
            style: robotoMedium,
          )
        ],
      );
    });
  }
}
