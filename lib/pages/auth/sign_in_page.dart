

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/custom_loader.dart';
import 'package:food_delivary_app/pages/auth/sign_up_page.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/app_text_field.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';

import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';


class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController){
      //var authController = Get.find<AuthController>(); //passing parameter so we dont need this
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
         
     if(email.isEmpty){
     showCoustomSnackBar("Type in your email address", title: "Email address");
      } else if(!GetUtils.isEmail(email)){
     showCoustomSnackBar("Type in your valid email address", title: "Valid email address");
      } else if (password.isEmpty){
      showCoustomSnackBar("Type in your password", title: "Passowrd");
      } else if (password.length<6){
      showCoustomSnackBar("Password can not be less then six characters", title: "Passowrd");
      } else{
     
      authController.login(email, password).then((status){
         if(status.isSuccess){
         Get.toNamed(RouteHelper.getInitial());
         } else{ 
          showCoustomSnackBar(status.message);
         }
      });
      }

    }
 

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController){
        return !authController.isLoading? SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: Dimensions.screenHeight*0.07,),
            //app logo
            Container(
              height:Dimensions.screenHeight*0.25 ,
              child: const Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 80,
                  backgroundImage: AssetImage(
                    "assets/image/logo part 1.png"
                  ),
                ),
              ),
            ),
            //Welcome
            Container(
              margin: EdgeInsets.only(left: Dimensions.width20),
              width: double.maxFinite,
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello",
                style: TextStyle(
                  fontSize: Dimensions.font20*3+Dimensions.font20/2,
                  fontWeight: FontWeight.bold
                ),
                ),
                 Text("Sign into your account",
                style: TextStyle(
                  fontSize: Dimensions.font20,
                 color: Colors.grey
                ),
                ),
              ],
             ),
            ),
            SizedBox(height: Dimensions.height20),
            //your email
            AppTextField(
              textController: emailController, 
              hinntText: "email", 
              icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //your password
               AppTextField(
              //  isObscure: true,
              textController: passwordController, 
              hinntText: "Password", 
              icon: Icons.password_sharp),
              SizedBox(height: Dimensions.height20,),
              //tag line
              Row(
              mainAxisAlignment: MainAxisAlignment.end,
               children: [
               // Expanded(child: Container(child: Text('ff'),)),
                 RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignUpPage()),
                    text: "Sign into your account",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                    ),
                  )
                  ),
                  SizedBox(width: Dimensions.width20),
               ],
             ),
               SizedBox(height: Dimensions.screenHeight*0.05,),
            //sign in button
             GestureDetector(
              onTap: (){
                _login(authController);
              },
               child: Container(
                width: Dimensions.screenWidth/2,
                height: Dimensions.screenHeight/13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: AppColors.mainColor
                ),
                child: Center(
                  child: BigText(
                    text: "Sign in",
                    size: Dimensions.font20+Dimensions.font20/2,
                    color: Colors.white,
                    ),
                ),
               ),
             ),
          
            
              SizedBox(height: Dimensions.screenHeight*0.05,),
             
              //sign up opttions
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: [
            RichText(
              text: TextSpan(
                    
                    text: "Don\'t have an account?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font20
                    ),
                    children: [
                      TextSpan(
                    recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>SignUpPage(),transition: Transition.fade),
                    text: " Create",
                    style: TextStyle(
                      color: AppColors.mainBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: Dimensions.font20
                    ),
                      )
                    ]
              )
              
              ),
                 ],
               ),
             
               
          ],
        ),
      ): CustomLoader();
      },)
    );
  }
}