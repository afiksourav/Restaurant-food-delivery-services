import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/popular_product_controller.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/route/route_helper.dart';

import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/app_const.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetail({super.key, required this.pageId,required this.page});

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().RecommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
//backgroundColor: Colors.white,
  body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned        : true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                GestureDetector(
                  onTap: (){
                   if(page=="cartpage"){
                    Get.toNamed(RouteHelper.getCartPage());
                   } else{
                     Get.toNamed(RouteHelper.getInitial());
                   }
                    
                  },
                  child: AppIcon(icon: Icons.clear),
                  ),
               // AppIcon(icon: Icons.shopping_cart_checkout_outlined)
                     GetBuilder<PopularProductController>(builder: (controller) {
                    return GestureDetector(
                      onTap: (){
                            if (controller.totalItems >= 1) {
                              Get.toNamed(RouteHelper.getCartPage());
                            }
                              },
                      child: Stack(
                        children: [
                          const AppIcon(
                            icon: Icons.shopping_cart_outlined,),
                            controller.totalItems>=1?
                          const Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(icon: Icons.circle,
                            size: 20,iconColor:
                             Colors.transparent,
                             backgroundColor: AppColors.mainColor,),
                          )
                          : Container(),
                    
                          //number
                             Get.find<PopularProductController>().totalItems>=1?
                           Positioned(
                            right: 4,
                            top: 3,
                            child:BigText(text:Get.find<PopularProductController>().totalItems.toString() ,
                            size: 12,color: Colors.white,
                            )
                          )
                          : Container()
                        ],
                      ),
                    );
                  })
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                   AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height10 / 2, bottom: Dimensions.height10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20)),
                  color: Colors.white,
                 
                ),
                child: Center(
                    child: BigText(
                  text: product.name!,
                  size: Dimensions.font26,
                )),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                  child:  ExpandableTextWidget(text: product.description!),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (controller) {
        return Column(
          mainAxisSize: MainAxisSize.min,  //when we use customscrollview then if we need bottom nav bar and column then obesely use MainAxisSize.min because otherwise bottom nav bar dont't show the screeen   
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.width20*2.5,
                right: Dimensions.width20*2.5,
                top: Dimensions.height10,
                bottom: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                       controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove,iconSize: Dimensions.iconSize24, backgroundColor: AppColors.mainColor, iconColor: Colors.white,)),
                  BigText(text:  "\$${product.price} X  ${controller.inCartItems} ",size: Dimensions.font26,color: AppColors.mainBlackColor,),
                  GestureDetector(
                    onTap: (){
                     controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,iconSize: Dimensions.iconSize24,backgroundColor: AppColors.mainColor, iconColor: Colors.white))
                ],
              ),
            ),
          Container(
          height: Dimensions.bottomHeightBar120,
          decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius20*2),
              topRight: Radius.circular(Dimensions.radius20*2)
            )
          ),
      
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
      
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white
                ),
                child: const Icon(Icons.favorite, color: AppColors.mainColor,)
              ),
              GestureDetector(
                onTap: (){
                  controller.addItem(product);
                },
                child: Container(
                   margin: EdgeInsets.only(right: Dimensions.width20),
                        padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor
                  ),
                  child:  BigText(text: "\$${product.price} | Add to Cart",color: Colors.white,),
                ),
              )
            ],
          ),
        
        ),
          ],
        );
      },),
    );
  }
}
