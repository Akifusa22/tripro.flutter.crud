import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/add_new_property_meet_with_a_agent_screen.dart';
import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/secondscreenpro.dart';
import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/thirdscreenpro.dart';
import 'package:aokiji_s_application4/presentation/filter_screen/filter_screen.dart';
import 'package:flutter/material.dart';
import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_subtitle.dart';
import 'package:aokiji_s_application4/widgets/app_bar/custom_app_bar.dart';
import '../notification_screen/widgets/square2screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationScreen extends StatelessWidget {
  List<Map<String, dynamic>> itemList = [
    {
      'title': "LÊN LỊCH KIỂM TRA THIẾT BỊ QUAN TRẮC",
      'icon': Icons.star,
    },
    {
      'title': "THEO DÕI LỊCH HẸN",
      'icon': Icons.favorite,
    },
    {
      'title': "ĐỔI LỊCH HẸN",
      'icon': Icons.shopping_cart,
    },
    
    // Thêm các dữ liệu cho item 4, 5, 6 tương tự
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.gray50,
        appBar: CustomAppBar(
          height: getVerticalSize(48),
          leadingWidth: 64,
          leading: AppbarIconbutton1(
            svgPath: ImageConstant.imgArrowleft,
            margin: getMargin(left: 24),
            onTap: () {
              onTapArrowleft(context);
            },
          ),
          centerTitle: true,
          title: AppbarSubtitle(text: "Danh sách dịch vụ"),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            padding: getPadding(
              left: 11,
              top: 24,
              right: 11,
              bottom: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    "",
                    textAlign: TextAlign.left,
                    style: AppStyle.txtManropeBold16.copyWith(
                      letterSpacing: getHorizontalSize(0.2),
                    ),
                  ),
                ),
                SizedBox(height: getVerticalSize(29)),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: itemList.length,
                  itemBuilder: (context, index) {
                    final itemData = itemList[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: getVerticalSize(16)),
                      child: Square2screen(
                        title: itemData['title'],
                        icon: itemData['icon'],
                        onTap: () {
                          if (itemData['title'] == "Price board") {
                            // Thực hiện hành động liên quan đến Price board
                          } else if (itemData['title'] ==
                              "LÊN LỊCH KIỂM TRA THIẾT BỊ QUAN TRẮC") {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DateTimePickerScreen()),
                            );
                            // Thực hiện hành động liên quan đến List of services
                          } else if (itemData['title'] == "THEO DÕI LỊCH HẸN") {
                            navigateToDataDisplayScreen(context);
                            // Thực hiện hành động liên quan đến Customer service
                          } else if(itemData['title'] == "ĐỔI LỊCH HẸN"){
                            nagvigateToThirdScreenPro(context);
                          }
                           else if (itemData['title'] == "UNDER DEVELOPMENT") {
                            // Thực hiện hành động liên quan đến Customer service
                          }
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToDataDisplayScreen(BuildContext context) {
    User? user =
        FirebaseAuth.instance.currentUser; // Lấy đối tượng người dùng hiện tại
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DataDisplayScreen(
            user: user!), // Truyền đối tượng người dùng vào đây
      ),
    );
  }
  void nagvigateToThirdScreenPro(BuildContext context)
  {
    User? user =
        FirebaseAuth.instance.currentUser; // Lấy đối tượng người dùng hiện tại
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DataEditScreen(
            user: user!), // Truyền đối tượng người dùng vào đây
      ),
    );
  } 
  void onTapArrowleft(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterScreen(), // Truyền đối tượng người dùng vào đây
      ),
    );
  }
}
