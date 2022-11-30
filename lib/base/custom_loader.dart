import 'package:flutter/material.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/controllers/user_controllers.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    //print("i am printing loading state"+Get.find<UserController>().isLoading.toString() );
    return Center(
      child: Container(
        height: Dimensions.height20*5,
        width: Dimensions.height20*5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height20*5/2),
          color: AppColors.mainColor
        ),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    );
  }
}