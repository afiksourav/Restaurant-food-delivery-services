import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/recommended_product_controller.dart';
import 'package:food_delivary_app/models/popular_product_model.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:food_delivary_app/utils/app_const.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/app_Column_star.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:food_delivary_app/widgets/icon_and_text_widget.dart';
import 'package:food_delivary_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../controllers/popular_product_controller.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  // all slider size control

  var _currPageValue = 0.0;

  final double _scaleFactor = 0.8;

  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider sectons
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isloaded
              ? Container(
                  height: Dimensions.pageView,
                  
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: popularProducts.popularProductList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position,
                            popularProducts.popularProductList[position]);
                      }),
                )
              : const CircularProgressIndicator(color: AppColors.mainColor,);
        }),
        //Dosts section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        //Recommended item section

        SizedBox(
          height: Dimensions.height30,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: BigText(
                    text: ".",
                    color: Colors.black26,
                  )),
              SizedBox(
                width: Dimensions.width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: SmallText(text: "food pairing"),
              )
            ],
          ),
        ),
        SizedBox(
          height: Dimensions.height30,
        ),

       GetBuilder<RecommendedProductController>(builder:(recommendedProducts){
        return recommendedProducts.isloaded
        ? ListView.builder(
             physics:
                  NeverScrollableScrollPhysics(), //scrolling probelm soluation
            shrinkWrap: true,
            itemCount: recommendedProducts.RecommendedProductList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
             Get.toNamed(RouteHelper.getRecommendedFood(index,"Home"));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: Dimensions.height10),
                  child: Row(
                    children: [
                      // image sections
                      Container(
                        width: Dimensions.listViewImgSize,
                        height: Dimensions.listViewImgSize,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white38,
                            image:  DecorationImage(
                                image: NetworkImage(
                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+recommendedProducts.RecommendedProductList[index].img!
                                  ),),),
                      ),
              
                      //text container
                      Expanded(
                        child: Container(
                          height: Dimensions.listViewTextSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.radius20),
                                bottomRight: Radius.circular(Dimensions.radius20),
                              ),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Dimensions.width10,
                                right: Dimensions.width10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: recommendedProducts.RecommendedProductList[index].name!),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  SmallText(text:"china of products cina" ),
                                  SizedBox(
                                    height: Dimensions.height10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      IconAndTextWidget(
                                          icon: Icons.circle_sharp,
                                          text: "Normal",
                                          iconColor: AppColors.iconColor1),
                                      IconAndTextWidget(
                                          icon: Icons.location_on,
                                          text: "1.7km",
                                          iconColor: AppColors.mainColor),
                                      IconAndTextWidget(
                                          icon: Icons.access_time_rounded,
                                          text: "32min",
                                          iconColor: AppColors.iconColor2)
                                    ],
                                  )
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
            : const CircularProgressIndicator(color: AppColors.mainColor,);
       } ),
       
       
      
      
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      //slider animition logic
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);

      var currTrans = _height * (1 - currScale) / 2; //2nd side height logic
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans =
          _height * (1 - currScale) / 2; // 2nd side height logic same
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 1);
    }
    return Transform(
      transform: matrix, //user this matrix logic
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              
               Get.toNamed(RouteHelper.getPopularFood(index, "Home"));
            //  Get.to(PopularFoodDetail(pageId: index,));

            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + popularProduct.img!,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 5.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ]),
              child: Container(
                  padding: EdgeInsets.only(
                      top: Dimensions.height15,
                      left: Dimensions.height15,
                      right: Dimensions.height15),
                  child: AppColumnStar(
                    text: popularProduct.name!,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
