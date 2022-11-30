import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:food_delivary_app/utils/colors.dart';

import '../utils/dimansion.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hinntText;
  final IconData icon;
  bool isObscure;
   AppTextField({super.key , this.isObscure=false, required this.textController, required this.hinntText, required this.icon});
  


  @override
  Widget build(BuildContext context) {
    return Container(
            margin: EdgeInsets.only(left: Dimensions.height20,right: Dimensions.height20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 1,
                  offset: Offset(1,1),
                  color: Colors.grey.withOpacity(0.2)
                )
              ]
            ),
        child: TextField(
          obscureText: isObscure ?true:false,
          controller: textController,
          //hinntText ,border,enableBorder, profixIcon, focussedBorder/
          decoration: InputDecoration(
            //hinntText
            hintText:hinntText,
            //profixIcon
            prefixIcon: Icon(icon,color: AppColors.mainColor,),
            //focussedBorder
            focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(Dimensions.radius15),
           borderSide: BorderSide(
            width: 1.0,
            color: Colors.white
           )
          ),
          //enableBorder
          enabledBorder:OutlineInputBorder(
           borderRadius: BorderRadius.circular(Dimensions.radius15),
           borderSide: BorderSide(
            width: 1.0,
            color: Colors.white
           )
          ), 
          //border
          border:OutlineInputBorder(
           borderRadius: BorderRadius.circular(Dimensions.radius15),
          
          ),  
          ),
          ),
          );
  }
}