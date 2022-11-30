import 'package:food_delivary_app/pages/address/add_address_page.dart';
import 'package:food_delivary_app/pages/auth/sign_in_page.dart';
import 'package:food_delivary_app/pages/cart_screen/cart_screen.dart';
import 'package:food_delivary_app/pages/food_screen/popular_food_detail.dart';
import 'package:food_delivary_app/pages/food_screen/recommendded_food_details.dart';
import 'package:food_delivary_app/pages/home_screen/home_page.dart';
import 'package:food_delivary_app/pages/home_screen/main_food_page.dart';
import 'package:food_delivary_app/pages/splash_screen/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper{
  
  static const String  splashPage="/splash-page";
  static const String initial="/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage= "/cart-page";
  static const String signIn= "/sign-in";   //auth
  static const String addAdress ="/add-address";
  


  static String getSplashPage()=>'$splashPage';
  static String getInitial()=>'$initial';
  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId ,String page)=>'$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage()=>'$cartPage';
  static String getSignInPage()=>'$signIn';   //auth
  static String getAddressPage()=>'$addAdress';


  static List<GetPage>routes=[
    GetPage(name: splashPage, page: ()=> SplashScreen()),
    GetPage(name: initial, page: ()=> HomePage()),
    //auth
    GetPage(name: signIn, page: ()=> SignInPage(),
                  transition: Transition.fade),
    
     GetPage(name: popularFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return  PopularFoodDetail(pageId: int.parse(pageId!),page:page!);
    },transition: Transition.fadeIn),

    GetPage(name: recommendedFood, page: (){
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return  RecommendedFoodDetail(pageId:int.parse(pageId!),page: page!);
    },transition: Transition.fadeIn),

    GetPage(name: cartPage, page: (){
      return CartPage();
    },
    transition: Transition.fadeIn),

    GetPage(name: addAdress, page: (){
      return AddAddressPage();
    })
  ];
}