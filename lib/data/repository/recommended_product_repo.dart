import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

// when we look data from internet, we have to extends GetxService
class RecommendedProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommendedProductRepo({required this.apiClient});

  Future<Response> getRecommendedProductList() async{
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}

/*
* repository should have access the api client
* repository should have instance of api client
*
*
* */