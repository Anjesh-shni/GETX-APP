import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_lemon_app/core/base/custom_loader.dart';
import '../../../config/route/routes_helper.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_dimension.dart';
import '../../getx_controller/controller/auth_controller.dart';
import '../../getx_controller/controller/cart_controller.dart';
import '../../getx_controller/controller/user_controller.dart';
import '../widget/accoun_widget.dart';
import '../widget/app_icon.dart';
import '../widget/bigtext.dart';
import '../widget/custom_button.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: BigText(
          text: "Profiles",
          size: 20,
        ),
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return userLoggedIn
            ? (userController.isLoading
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        // profiles
                        Container(
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: AppIcon(
                            icon: Icons.person,
                            backgound: ApClrs.mainBlackClr,
                            size: Dimen.height15 * 9,
                            iconSize: Dimen.height45 + Dimen.height30,
                            iconColor: Colors.white,
                          ),
                        ),
                        //Name
                        Column(
                          children: [
                            SizedBox(height: Dimen.height10),
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.person,
                                backgound: ApClrs.mainClr,
                                size: Dimen.height10 * 5,
                                iconSize: Dimen.height15 + Dimen.height10,
                                iconColor: ApClrs.mainBlackClr,
                              ),
                              bigText: BigText(
                                text:
                                    //  "Anjesh Kumar",
                                    userController.userModel.name,
                                color: ApClrs.textfontgreyColor,
                              ),
                            ),
                            //phone
                            SizedBox(height: Dimen.height10),
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.phone,
                                backgound: ApClrs.yllowClr,
                                size: Dimen.height10 * 5,
                                iconSize: Dimen.height15 + Dimen.height10,
                                iconColor: Colors.white,
                              ),
                              bigText: BigText(
                                text: userController.userModel.phone,
                                //  "9819868628",
                                color: ApClrs.textfontgreyColor,
                              ),
                            ),
                            //Email
                            SizedBox(height: Dimen.height10),
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.email,
                                backgound: ApClrs.yllowClr,
                                size: Dimen.height10 * 5,
                                iconSize: Dimen.height15 + Dimen.height10,
                                iconColor: Colors.grey,
                              ),
                              bigText: BigText(
                                text: userController.userModel.email,
                                // "Anjeshshni1@gmail.com",
                                color: ApClrs.textfontgreyColor,
                              ),
                            ),
                            //Location
                            SizedBox(height: Dimen.height10),
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.location_on,
                                backgound: ApClrs.yllowClr,
                                size: Dimen.height10 * 5,
                                iconSize: Dimen.height15 + Dimen.height10,
                                iconColor: Colors.green,
                              ),
                              bigText: BigText(
                                text: "Kapan",
                                color: ApClrs.textfontgreyColor,
                              ),
                            ),
                            SizedBox(height: Dimen.height10),
                            AccountWidget(
                              appIcon: AppIcon(
                                icon: Icons.message,
                                backgound: Colors.red,
                                size: Dimen.height10 * 5,
                                iconSize: Dimen.height15 + Dimen.height10,
                                iconColor: Colors.white,
                              ),
                              bigText: BigText(
                                text: "Notifications",
                                color: ApClrs.textfontgreyColor,
                              ),
                            ),
                            SizedBox(height: Dimen.height10),
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  Get.find<AuthController>().clearSharedData();
                                  Get.find<CartController>().clear();
                                  Get.find<CartController>().clearCartHistory();
                                  Get.offNamed(RouteHelper.getSignIn());
                                } else {
                                  Get.snackbar(
                                    "You can't logout",
                                    "Because you are not logged-in",
                                    backgroundColor: ApClrs.mainClr,
                                    colorText: Colors.black,
                                    snackPosition: SnackPosition.TOP,
                                  );
                                }
                              },
                              child: AccountWidget(
                                appIcon: AppIcon(
                                  icon: Icons.logout_rounded,
                                  backgound: Colors.grey,
                                  size: Dimen.height10 * 5,
                                  iconSize: Dimen.height15 + Dimen.height10,
                                  iconColor: ApClrs.mainBlackClr,
                                ),
                                bigText: BigText(
                                  text: "Logout",
                                  color: ApClrs.textfontgreyColor,
                                ),
                              ),
                            ),
                            SizedBox(height: Dimen.height10),
                          ],
                        ),
                      ],
                    ),
                  )
                : const CustomLoader())
            : Container(
                child: customButton(
                    onPress: () {
                      Get.toNamed(RouteHelper.getSignIn());
                    },
                    color: ApClrs.bodyColor,
                    textColor: ApClrs.textfontgreyColor,
                    title: "login"),
              );
      }),
    );
  }
}
