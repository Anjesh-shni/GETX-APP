import 'package:get/get.dart';
import '../../data/repository/auth_repo.dart';
import '../../domain/model/main_model/response_model.dart';
import '../../domain/model/main_model/sign_up_body.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    //Create user account
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async {
    //Login method
    // print("getting token" + authRepo.getUserToken().toString());
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"].toString());
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      //Error text from getX model itself i,e= statusText
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) {
    //Saving credentials
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    //Boolean to check either user logged-in or NOt
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    //Remove data from sharedPrefrences
    return authRepo.clearSharedData();
  }
}
