import 'package:food_delivary_app/data/repository/auth_repo.dart';
import 'package:food_delivary_app/models/response_model.dart';
import 'package:food_delivary_app/models/signup_body_model.dart';
import 'package:get/get.dart';

class AuthController extends GetxController implements GetxService{
   final AuthRepo authRepo;
   AuthController({
    required this.authRepo
   });
   bool _isLoading = false;
   bool get isLoading => _isLoading;

   Future<ResponseModel> registration(SignUpBody signUpBody) async {
    _isLoading =true;
    update();
   Response response =await authRepo.registration(signUpBody);
   late ResponseModel responseModel;
   if(response.statusCode==200){
      authRepo.saveUserToken(response.body["token"]);
      responseModel =ResponseModel(true, response.body["token"]);
   }else{
      responseModel =ResponseModel(false, response.statusText!);
   }
   _isLoading=false;
   update();
   return responseModel;
   }

  //Login
   Future<ResponseModel> login(String email,String password) async {
   //print("gattring token");
  // print( authRepo.getUserToken().toString());
    _isLoading =true;
    update();
   Response response =await authRepo.login(email,password);
   late ResponseModel responseModel;

   if(response.statusCode==200){
   // print("backend token");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"]);
      responseModel =ResponseModel(true, response.body["token"]);
   }else{
      responseModel =ResponseModel(false, response.statusText!);
   }
   _isLoading=false;
   update();
   return responseModel;
   }


 voidsaveUserNumberAndPassword(String number, String password) async {
   authRepo.saveUserNumberAndPassword(number, password);
  }
 
 //user is login so cart checkout is next step outherwise signIn page go
  bool userLoggedIn()  {
    return  authRepo.userLoggedIn();
  }

  bool clearSharedData(){
   return authRepo.clearSharedData();
  }
   
}