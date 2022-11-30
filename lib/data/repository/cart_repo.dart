import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:food_delivary_app/utils/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';
class CartRepo {

  final SharedPreferences sharedPreferences;
  CartRepo ({required this.sharedPreferences});
   
   List<String> cart = [];
   List<String> cartHistory =[];

   void addToCartList(List<CartModel> cartList){
      // sharedPreferences.remove(AppConstants.CART_LIST);
      // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
      // return;
        var timeNow = DateTime.now().toString();
        cart = [];
        /*
        convert objects to string because sharedPreferences only aaccept string
        */
        cartList.forEach((element) {
          element.time = timeNow;
          return cart.add(jsonEncode(element));
          
        });
        //short formate
      //  cartList.forEach((element) =>cart.add(jsonEncode(element))); 
        sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
        //print(sharedPreferences.getStringList(AppConstants.CART_LIST)); 
       // getCartList();
   }
// convert string to object
   List<CartModel> getCartList(){
    List <String> carts = [];  
    if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!; //upor a convert kora string carts list a add kora holo
      print("indise getcartlist"+carts.toString());
    
    }
    List <CartModel> cartList = [];
    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element))); //carts string data gula object convert kora holo jar kaone jsonDecode use kora hoicay 
    });
    //usering short formate
    //carts.forEach((element) =>CartModel.fromJson(jsonDecode(element))); 

    return cartList;  //addd kora object gula cartList return kora holo
   }
   //checkout er por faka hoya jaoa cart er history
   List<CartModel>getCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory =[];
      cartHistory = sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    List <CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
    return cartListHistory;
   }
   
   void addToCartHistoryList(){
    if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
      cartHistory= sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for(int i =0; i<cart.length;i++){
      print("history list "+cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST,cartHistory);
    print("lenth of history list is "+getCartHistoryList().length.toString());
    for(int a= 0; a<getCartHistoryList().length;a++){
print("the time for the order"+getCartHistoryList()[a].time.toString());
    }
    
   }

   void removeCart(){
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
   }

   void clearCartHistory(){
    removeCart();
    cartHistory=[];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
   }
   

}