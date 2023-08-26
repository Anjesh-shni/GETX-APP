import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/base/custom_loader.dart';
import '../../../core/base/show_custom_msg.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimension.dart';
import '../../getx_controller/controller/auth_controller.dart';
import '../widget/app_text_field.dart';
import '../widget/bigtext.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCuastomSnackBAr("Type in your email", title: "Email");
      } else if (!GetUtils.isEmail(email)) {
        showCuastomSnackBAr("Type valid email address", title: "Invalid email");
      } else if (password.isEmpty) {
        showCuastomSnackBAr("Type in your password", title: "password");
      } else if (password.length < 6) {
        showCuastomSnackBAr("password cannot be less than 6-character",
            title: "password");
      } else {
        showCuastomSnackBAr("Your Account  has been created!",
            title: "Welcome");

        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCuastomSnackBAr(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return !authController.isLoading
              ? SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimen.screenHeight * 0.05,
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        child: const Center(
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              "assets/icons/logo_w.jpeg",
                            ),
                            radius: 300,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: Dimen.width20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              "Sign into your account",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                            SizedBox(
                              height: Dimen.height10,
                            ),
                          ],
                        ),
                      ),
                      AppTextField(
                          icon: Icons.phone,
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
                        height: Dimen.height10,
                      ),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          RichText(
                            text: TextSpan(
                              text: "Sign into your account",
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: Dimen.width20,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Dimen.width20 * 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          _login(authController);
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
                              text: "Sign in",
                              color: Colors.black,
                              // size: Dimen.font20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimen.screenHeight * 0.10,
                      ),
                      RichText(
                        text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      Get.toNamed(RouteHelper.getSignUp()),
                                text: "Create",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                )
              : const CustomLoader();
        },
      ),
    );
  }
}
