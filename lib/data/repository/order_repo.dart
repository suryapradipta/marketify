import 'package:get/get.dart';
import 'package:marketify/data/api/api_client.dart';
import 'package:marketify/utils/app_constants.dart';

import '../../models/place_order_model.dart';

class OrderRepo {
  final ApiClient apiClient;

  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrder) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrder.toJson());
  }
}
