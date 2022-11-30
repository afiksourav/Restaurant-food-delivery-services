
import 'package:flutter/material.dart';
import 'package:food_delivary_app/pages/home_screen/food_page_body.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';


import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {

  
 Future<void> _leadResource() async{
  await Get.find<PopularProductController>().getPopularProductListController();  //api*
  await  Get.find<RecommendedProductController>().getRecommendedProductListController(); 
  }
  
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      
      onRefresh: _leadResource,
      
      child: Column(
        children: [
        Container(
          margin:  EdgeInsets.only(top: Dimensions.height45,bottom: Dimensions.height15),
          padding:  EdgeInsets.only(left: Dimensions.width20, right:  Dimensions.width20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children:  [
                 BigText(text: "Bangladesh",color: AppColors.mainColor,),
                 Row(
                  children: [
                    SmallText(text: "Narshindhi",color: Colors.black54,),
                   const Icon(Icons.arrow_drop_down_rounded)
                  ],
                 )
                  
        
                    ],
                  ),
                  Center(
                    child: Container(
                       width: Dimensions.widtht45,
                       height: Dimensions.height45,
                      decoration:  BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                      ),
                      child:  Icon(Icons.search, color: Colors.white, size: Dimensions.iconSize24,),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
       const SizedBox(height: 15,),
        const Expanded(
          child:SingleChildScrollView(
            child: FoodPageBody(),
          ) 
          )
        ],
        
      ));
    
  }
}