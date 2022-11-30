import 'package:food_delivary_app/models/popular_product_model.dart';
import 'package:get/get.dart';

import '../data/repository/recommended_product_repo.dart';


class RecommendedProductController extends GetxController{
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<ProductModel> _recommendedProductList = [];
  List<ProductModel> get RecommendedProductList => _recommendedProductList;
  
  bool _isLoaded = false;
  bool get isloaded => _isLoaded;
      
  Future<void> getRecommendedProductListController()async{
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if(response.statusCode==200){
      _recommendedProductList =[];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
  } else{
    print("coluld not get products recommended");

  }
} 
}