import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/custom_loader.dart';
import '../../../core/base/show_custom_msg.dart';
import '../../domain/model/main_model/sign_up_body.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimension.dart';
import '../../getx_controller/controller/auth_controller.dart';
import '../widget/app_text_field.dart';
import '../widget/bigtext.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImage = [
      "t.png",
      "go.png",
      "ff.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCuastomSnackBAr("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        showCuastomSnackBAr("Type in your phone Number", title: "Number");
      } else if (email.isEmpty) {
        showCuastomSnackBAr("Type in your Email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCuastomSnackBAr("Type valid Email address", title: "Invalid email");
      } else if (password.isEmpty) {
        showCuastomSnackBAr("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCuastomSnackBAr("password cannot be less than 6-character",
            title: "password");
      } else {
        // showCuastomSnackBAr("Your Account has been created!", title: "Welcome");
        SignUpBody signUpBody = SignUpBody(
            name: name, phone: phone, email: email, password: password);

        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCuastomSnackBAr(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimen.screenHeight * 0.05,
                      ),
                      Container(
                        height: Dimen.screenHeight * 0.25,
                        // margin: EdgeInsets.only(top: Dimen.height30 * 2),
                        child: const Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage("images/acc.png"),
                            radius: 60,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      AppTextField(
                          icon: Icons.email,
                          textController: emailController,
                          hintText: "Email"),
                      SizedBox(
                        height: Dimen.height20,
                      ),
                      AppTextField(
                          isObscure: true,
                          icon: Icons.password,
                          textController: passwordController,
                          hintText: "Password"),
                      SizedBox(
                        height: Dimen.height20,
                      ),
                      AppTextField(
                          icon: Icons.person,
                          textController: nameController,
                          hintText: "Name"),
                      SizedBox(
                        height: Dimen.height20,
                      ),
                      AppTextField(
                          icon: Icons.phone,
                          textController: phoneController,
                          hintText: "Phone"),
                      SizedBox(
                        height: Dimen.height40,
                      ),
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          // margin: EdgeInsets.only(left: Dimen.width30, right: Dimen.width30),
                          width: Dimen.screenwidth / 2,
                          height: Dimen.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimen.radius20),
                              color: ApClrs.mainClr),
                          child: Center(
                            child: BigText(
                              text: "Sign up",
                              // size: Dimen.font20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimen.height10,
                      ),
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimen.screenHeight * 0.04,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Sign up using one of the fallowing methods",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: Dimen.radius30,
                              backgroundImage:
                                  AssetImage("images/${signUpImage[index]}"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
