import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../data/repository/order_repo.dart';
import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;

  OrderController({required this.orderRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int _paymentIndex = 0;

  int get paymentIndex => _paymentIndex;

  String _orderType = "delivery";

  String get orderType => _orderType;

  String _foodNote = " ";
  String get foodNote => _foodNote;

  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
    if (response.statusCode == 200) {
      _isLoading = false;
      String message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID);
    } else {
      callback(false, response.statusText!, '-1');
    }
  }

  void setPaymentIndex(int index) {
    _paymentIndex = index;
    update();
  }

  void setDeliveryType(String type) {
    _orderType = type;
    update();
  }

  void setFoodNote(String note) {
    _foodNote = note;
  }
}
