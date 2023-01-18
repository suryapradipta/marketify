import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

// when we look data from internet, we have to extends GetxService
class PopularProductRepo extends GetxService {
  final ApiClient apiClient;
  PopularProductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async{
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    // return await apiClient.getData(AppConstants.DRINKS_URI);

  }
}

/*
* repository should have access the api client
* repository should have instance of api client
*
*
* */