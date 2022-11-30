import 'package:flutter/material.dart';
import 'package:food_delivary_app/models/cart_model.dart';
import 'package:food_delivary_app/models/popular_product_model.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:get/get.dart';

import '../data/repository/cart_repo.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  /*
  only fo rstorage and sharedpreferences
  */
  List <CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id!)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;

        return CartModel(
          id: value.id,
          name: value.name,
          price: value.price,
          img: value.img,
          quantity: value.quantity! + quantity,
          isExist: true,
          time: DateTime.now().toString(),
          product: product,
        );
      });
      //if(quantity<=0){} alternative use
      if (totalQuantity <= 0) {
        _items.remove(product.id);

      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
            id: product.id,
            name: product.name,
            price: product.price,
            img: product.img,
            quantity: quantity,
            isExist: true,
            time: DateTime.now().toString(),
            product: product,
          );
        });
      } else {
        Get.snackbar("Item count", "You should at least add one item",
            backgroundColor: AppColors.mainColor, colorText: Colors.white);
      }
    }
    cartRepo.addToCartList(getAllItems);
    update();
  }

  bool existInCart(ProductModel product) {
    if (_items.containsKey(product.id)) {
      return true;
    } //alredy  cart item add or remove then return true . 1st time add or remove item then return false
    return false;
  }

  //check update quantity
  int getQuantity(ProductModel product) {
    var quantity = 0; //already - or + cart item show getQuantity of number
    if (_items.containsKey(product.id)) {
      _items.forEach((key, value) {
        if (key == product.id) {
          quantity = value.quantity!;
        
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity = totalQuantity + value.quantity!;
    });
    return totalQuantity;
  }

  List<CartModel> get getAllItems {
    return _items.entries.map((e) {         //all items create a list
      return e.value;
    }).toList();
  }

int get totalAmount{
  var total = 0;
  _items.forEach((key, value) {
    total +=value.quantity!*value.price!; 
  });
  return total;
    
}
//store data in to local divice
List<CartModel> getCartData(){    
  setCart = cartRepo.getCartList();
  return storageItems;
}

//get always return something but set is alwayes accept something
set setCart(List<CartModel> items){  
  storageItems = items;
  print("length of cart items  "+storageItems.length.toString());
  for (int i=0; i<storageItems.length;i++){
    _items.putIfAbsent(storageItems[i].product!.id!, () =>
     storageItems[i]
     );
  }
}
void addToHistory(){
  cartRepo.addToCartHistoryList();
  clear();
}

void clear(){
  _items= {};
  update();
}

//main card history
List <CartModel> getCartHistoryList(){
  return cartRepo.getCartHistoryList();
}
//cart moreItems
set setItems(Map<int,CartModel> setItems){
  _items ={};
  _items = setItems;
}

void addToCartList(){
  cartRepo.addToCartList(getAllItems);
  update();
}

void clearCartHistory(){
  cartRepo.clearCartHistory();
  update();
}

}

