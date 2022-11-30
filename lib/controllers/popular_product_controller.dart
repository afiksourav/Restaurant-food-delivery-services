import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/data/repository/popular_product_repo.dart';
import 'package:food_delivary_app/models/popular_product_model.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;

  late CartController _cart; //cartcontroller set for instance of _cart

  bool _isLoaded = false;
  bool get isloaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems+_quantity;

  Future<void> getPopularProductListController() async {
    Response response = await popularProductRepo.getPopularProductList();

    if (response.statusCode == 200) {
      _popularProductList = [];

      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print("coluld not get products popular");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
  
      print("increment"+_quantity.toString());

    } else {
      _quantity = checkQuantity(_quantity -1);
      print("decrement"+_quantity.toString());
      
    }
    update();
  }

  int checkQuantity(int quantity) {     //checkQuantity use for manage setQuantity method
    if ((_inCartItems+quantity)<0) {
      print("_inCartItems is$_inCartItems quantityis  $quantity");
      Get.snackbar(
        "Item count",
        "you con't reduce more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;  //last check -1,-2,-3 then return 0 
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems+quantity)>20) {
      print("_inCartItems is$_inCartItems quantityis  $quantity");
      Get.snackbar(
        "Item count",
        "you con't add more !",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0; //ui add and remove pb solution
    _inCartItems = 0;
    _cart = cart;

    var exist = false;
    exist = _cart.existInCart(product);              //existInCart use alreday  add to cart item add or remove  then return true .
    print(" exist or not " + exist.toString());       //1st time add or remove item then return false
     if (exist) {
      _inCartItems = cart.getQuantity(product);    /// use already - or + cart item thats way call getQuantity method
     }
    print("the quantity in the car is " +_inCartItems.toString());
  }

  void addItem(ProductModel product) {
    //if (_quantity>0) { 
      _cart.addItem(product, _quantity);
      _quantity= 0;
      //add and remove button always 0 .there are no impact in add to card button
      _inCartItems = _cart.getQuantity(product); 
                /// use already - or + cart item thats way call getQuantity method
      _cart.items.forEach((key, value) {
        print("the id is " +value.id.toString() + " the quantity is " + value.quantity.toString());
      });
      update();
  }

   int get totalItems{
    return _cart.totalItems;
   }

   List<CartModel> get getAllItems{  //all items create a list
      return _cart.getAllItems;
   }


}


