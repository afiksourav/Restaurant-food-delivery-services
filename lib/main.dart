import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/popular_product_controller.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:get/get.dart';
import 'package:food_delivary_app/helper/dependencies.dart' as dep;

import 'controllers/recommended_product_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();         //api*
  await dep.init(); 
                         
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
  Get.find<CartController>().getCartData(); 
  return GetBuilder<PopularProductController>(builder: (_){
   return GetBuilder<RecommendedProductController>(builder: (_){
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    //  home:  SignInPage(),
      initialRoute: RouteHelper.getSplashPage(),
      getPages: RouteHelper.routes,
    );
   });
     });
  }
}
