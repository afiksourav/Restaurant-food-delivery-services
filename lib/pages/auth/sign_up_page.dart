

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivary_app/base/custom_loader.dart';
import 'package:food_delivary_app/base/show_custom_snackbar.dart';
import 'package:food_delivary_app/controllers/auth_controller.dart';
import 'package:food_delivary_app/models/signup_body_model.dart';
import 'package:food_delivary_app/pages/auth/sign_in_page.dart';
import 'package:food_delivary_app/route/route_helper.dart';
import 'package:food_delivary_app/utils/app_const.dart';
import 'package:food_delivary_app/utils/colors.dart';
import 'package:food_delivary_app/utils/dimansion.dart';
import 'package:food_delivary_app/widgets/app_text_field.dart';
import 'package:food_delivary_app/widgets/big_text.dart';
import 'package:get/get.dart';


class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var singUpImages= [
      "t.png",
      "f.png",
      "g.png"
    ];

      void _registraton(AuthController authController){
      //var authController = Get.find<AuthController>(); //passing parameter so we dont need this
      String name = nameController.text.trim();
      String phone = phoneController.text.trim(); 
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
         
      if(name.isEmpty){
        showCoustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty){
      showCoustomSnackBar("Type in your phone number", title: "Phone number");
      } else if(email.isEmpty){
     showCoustomSnackBar("Type in your email address", title: "Email address");
      } else if(!GetUtils.isEmail(email)){
     showCoustomSnackBar("Type in your valid email address", title: "Valid email address");
      } else if (password.isEmpty){
      showCoustomSnackBar("Type in your password", title: "Passowrd");
      } else if (password.length<6){
      showCoustomSnackBar("Password can not be less then six characters", title: "Passowrd");
      } else{
      showCoustomSnackBar("All went well", title: "Perfect");
      SignUpBody signUpBody = SignUpBody(
        name: name, 
        phone: phone,
        email: email,
        password: password,
   
      );
      authController.registration(signUpBody).then((status){
         if(status.isSuccess){
          print("success registrations");
         // Get.offAllNamed(RouteHelper.getInitial());
         } else{
          showCoustomSnackBar(status.message);
         }
      });
      }

    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder:(_authconroller){
        return !_authconroller.isLoading ? SingleChildScrollView(
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
            //your email
            AppTextField(
              textController: emailController, 
              hinntText: "email", 
              icon: Icons.email),
              SizedBox(height: Dimensions.height20,),
              //your password
               AppTextField(
                //isObscure: true,
              textController: passwordController, 
              hinntText: "Password", 
              icon: Icons.password_sharp,
              ),
              SizedBox(height: Dimensions.height20,),
              //your name
               AppTextField(
              textController: nameController, 
              hinntText: "Name", 
              icon: Icons.person),
              SizedBox(height: Dimensions.height20,),
              //your phone
               AppTextField(
              textController: phoneController, 
              hinntText: "Phone", 
              icon: Icons.phone),
              SizedBox(height: Dimensions.height20+Dimensions.height20,),
            
            //sign up button
             GestureDetector(
              onTap: (){
                 _registraton(_authconroller);
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
                    text: "Sign up",
                    size: Dimensions.font20+Dimensions.font20/2,
                    color: Colors.white,
                    ),
                ),
               ),
             ),
             SizedBox(
              height: Dimensions.height10,
             ),
             RichText(
              text: TextSpan(
                recognizer: TapGestureRecognizer()..onTap=()=>Get.to(SignInPage()),
                text: "Have an accout already",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font20
                ),
              )
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
      
              //sign up opttions
               RichText(
              text: TextSpan(
                
                text: "Sign up using one of the following methods",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimensions.font16
                ),
              )
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                   radius: Dimensions.radius30,
                   backgroundImage:AssetImage(
                    "assets/image/"+singUpImages[index]
                   ) ,
                  ),
                )),
              )
               
          ],
        ),
      ): const CustomLoader();
      },)
    
    
    );
  
  }
}