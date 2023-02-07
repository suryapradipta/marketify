import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';
import '../models/products_model.dart';

//
class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController({required this.recommendedProductRepo});

  // _ underscore in variable means private
  List<dynamic> _recommendedProductList = [];

  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // get product list from the server
  Future<void> getRecommendedProductList(bool reload) async {
    if(_recommendedProductList == null || reload) {
      // await needed because 'Future'
      Response response = await recommendedProductRepo
          .getRecommendedProductList();
      if (response.statusCode == 200) {
        // print("got products recommended");
        _recommendedProductList = [];
        _recommendedProductList.addAll(Product
            .fromJson(response.body)
            .products);
        _isLoaded = true;
        update();
      } else {
        print("could not get products recommended");
      }
    }
  }
}
