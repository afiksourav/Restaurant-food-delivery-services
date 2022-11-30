import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

 Future<void> _leadResource() async{
  await Get.find<PopularProductController>().getPopularProductListController();  //api*
  await  Get.find<RecommendedProductController>().getRecommendedProductListController(); 
  }

  @override
  void initState() {
    _leadResource();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.linear);

    Timer(
      const Duration(seconds: 3),
      () => Get.offAllNamed(RouteHelper.getInitial()),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ))),
          Center(
              child: Image.asset(
            "assets/image/logo part 2.png",
            width: Dimensions.splashImg,
          ))
        ],
      ),
    );
  }
}
