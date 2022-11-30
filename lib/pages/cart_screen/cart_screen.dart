import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/no_data_page.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/cart_controller.dart';
import 'package:food_delivary_app/controllers/location_controller.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:food_delivary_app/utils/app_const.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/app_icon.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';

class CartPage extends StatelessWidget {
//  final int pageId;
  const CartPage({
    super.key,
   // required this.pageId
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimensions.height20 * 3,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(()=>PopularFoodDetail(pageId: pageId));
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                SizedBox(width: Dimensions.width20 * 5),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(
                    icon: Icons.home_outlined,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimensions.iconSize24,
                  ),
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                )
              ],
            ),
          ),
         
         GetBuilder<CartController>(builder: (_cartController){
          return _cartController.getAllItems.length>0 ? Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(top: Dimensions.height15),
                //  color: Colors.red,
                child: MediaQuery.removePadding(
                    context: context,
                    removeTop:
                        true, //removePadding use for listview.builder and container padding remove
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getAllItems;

                        return ListView.builder(
                          itemCount: _cartList.length,
                          itemBuilder: ((_, index) {
                            return Container(
                              width: double.maxFinite,
                              height: Dimensions.height20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.height10),
                            
                              child: Row(
                                children: [
                                  //image section
                                  GestureDetector(
                                    onTap: (){
                var popularIndex =  Get.find<PopularProductController>()
                  .popularProductList
                  .indexOf(_cartList[index].product!);
                 
                  if(popularIndex>=0){
                    Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cartpage"));
                  } else{
                    var recommendedIndex = Get.find<RecommendedProductController>()
                    .RecommendedProductList
                    .indexOf(_cartList[index].product!);
                  if(recommendedIndex<0){
                         Get.snackbar("History Product", "Product review is not avaible for history product",
                         backgroundColor: AppColors.mainColor,
                         colorText: Colors.white
                         );
                  }else{
                       Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cartpage"));
                  }

                    
                  }
                                    },
                                    child: Container(
                                    width: Dimensions.height20 * 5,
                                    height: Dimensions.height20 * 5,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstants.BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    cartController
                                                        .getAllItems[index]
                                                        .img!)),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white),
                                  ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  //use expanded
                                  Expanded(
                                    child: Container(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(
                                            text: cartController
                                                .getAllItems[index].name!,
                                            color: Colors.black54,
                                          ),
                                          SmallText(text: "Spicy"),
                              
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                             
                                              BigText(
                                                text: "\$ "+cartController
                                                    .getAllItems[index].price
                                                    .toString(),
                                                color: Colors.redAccent,
                                              ),
                                               

                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: Dimensions.width20),
                                                padding: EdgeInsets.only(
                                                    top: Dimensions.height10,
                                                    bottom: Dimensions.height10,
                                                    left: Dimensions.width10,
                                                    right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    color: Colors.white),

                                                    
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                       cartController.addItem(_cartList[index].product!, -1);
                                                      },
                                                      child: Icon(Icons.remove,
                                                       color: AppColors.signColor,
                                                      ),
                                                    ),

                                                    SizedBox(
                                                      width: Dimensions.width10 /2,),
                                                    BigText(text:_cartList[index].quantity.toString()), //popularProduct.inCartItems.toString()), //show quantity
                                                    SizedBox(
                                                      width:
                                                          Dimensions.width10 /
                                                              2,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        cartController.addItem(_cartList[index].product!, 1);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                   
                                                  ],
                                                   
                                                ),
                                                
                                              ),
                                              
                                            ],
                                          ),
                                           
                                        ],
                                      ),
                                    ),
                                  ),
                                   
                                ],
                              ),
                             
                            );
                            
                          }),
                        );
                      },
                    )),
              )
              ):NoDataPage(text: "Your cart is empty"); 
         })
         
         
         
        ],
      ),
         bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimensions.bottomHeightBar120,
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2))),
              child: cartController.getAllItems.length>0? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20),
                    padding: EdgeInsets.only(
                        top: Dimensions.height20,
                        bottom: Dimensions.height20,
                        left: Dimensions.width20,
                        right: Dimensions.width20),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: Colors.white),
                    child: Row(
                      children: [
                      

                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                        BigText(
                            text:"\$ "+cartController.totalAmount.toString() ), //show quantity
                        SizedBox(
                          width: Dimensions.width10 / 2,
                        ),
                     
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     if(Get.find<AuthController>().userLoggedIn()){
                    // print("tapped");
                   // cartController.addToHistory();
                   if(Get.find<LocationController>().addressList.isEmpty){
                     Get.toNamed(RouteHelper.getAddressPage());
                     }
                     } else{
                      Get.toNamed(RouteHelper.getSignInPage());
                     }
                 
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: Dimensions.width20),
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: BigText(
                        text: "Check Out",
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ) : Container()
            );
          },
        )
    );
  }
}
