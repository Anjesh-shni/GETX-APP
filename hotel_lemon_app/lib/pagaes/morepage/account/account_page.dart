import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../route/routes_helper.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimension.dart';
import '../../../widget/accoun_widget.dart';
import '../../../widget/app_icon.dart';
import '../../../widget/bigtext.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        centerTitle: true,
        title: BigText(
          text: "Profiles",
          size: 20,
        ),
      ),
      body:
          // GetBuilder<UserController>(
          //   builder: (userController) {
          //     return
          // _userLoggedIn
          //     ? (userController.isLoading
          //         ?
          Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: Dimen.height20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          children: [
            // profiles
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: AppIcon(
                icon: Icons.person,
                backgound: ApClrs.mainBlackClr,
                size: Dimen.height15 * 10,
                iconSize: Dimen.height45 + Dimen.height30,
                iconColor: Colors.white,
              ),
            ),
            //Name
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                        text: "Anjesh Kumar",
                        //  userController.userModel.name,
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
                        text: "9819868628",
                        //  userController.userModel.phone,
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
                        text: "Anjeshshni1@gmail.com",
                        // userController.userModel.email,
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
                        text: "Kapan, futsal ground",
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
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                    GestureDetector(
                      onTap: () {
                        Get.offNamed(RouteHelper.getSignIn());
                        // if (Get.find<AuthController>().userLoggedIn()) {
                        //   Get.find<AuthController>().clearSharedData();
                        //   Get.find<CartController>().clear();
                        //   Get.find<CartController>().clearCartHistory();
                        //   Get.offNamed(RouteHelper.getSignIn());
                        // } else {
                        //   Get.snackbar(
                        //     "You haven't logged in yet",
                        //     "Please logged In",
                        //     backgroundColor: ApClrs.mainClr,
                        //     colorText: Colors.black,
                        //     snackPosition: SnackPosition.TOP,
                        //   );
                        // }
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
                        ),
                      ),
                    ),
                    SizedBox(height: Dimen.height10),
                  ],
                ),
              ),
            ),
          ],
        ),

        //     : CustomLoader())
        // : Container(
        //     color: Colors.green.shade100,
        //     child: Center(
        //         child: BigText(
        //       text: "You Must Login first !!!",
        //     )),
        //   );
      ),
    );
  }
}
