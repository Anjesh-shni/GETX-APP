import 'package:get/get.dart';
import '../../data/repository/user_repo.dart';
import '../../domain/model/main_model/response_model.dart';
import '../../domain/model/main_model/user_model.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    // print("user responsw${response.body}}");
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      // print("${response.body}");
      _userModel = UserModel.fromJson(response.body);
      // print("this is user model ${_userModel.name}");
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
