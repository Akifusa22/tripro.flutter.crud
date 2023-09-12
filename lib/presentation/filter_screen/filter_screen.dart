import 'package:aokiji_s_application4/auth.dart';
import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/add_new_property_meet_with_a_agent_screen.dart';
import 'package:aokiji_s_application4/presentation/notification_screen/widgets/square2screen.dart';
import 'package:aokiji_s_application4/presentation/sign_in_screen/sign_in_screen.dart';

import 'package:aokiji_s_application4/widgets/app_bar/appbar_subtitle.dart';
import 'package:aokiji_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:aokiji_s_application4/widgets/custom_icon_button.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/secondscreenpro.dart';
import 'package:aokiji_s_application4/presentation/add_new_property_meet_with_a_agent_screen/thirdscreenpro.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(userEmail: "example@email.com"),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Ngăn người dùng sử dụng nút back
      },
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Services',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Future<bool> onBackPressed() {
    // Không thực hiện hành động khi người dùng nhấn nút back
    return Future.value(false);
  }
}

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // Trạng thái tải dữ liệu
  late Future<void> dataLoading;
  @override
  void initState() {
    super.initState();
    dataLoading = loadData(); // Gọi hàm tải dữ liệu khi initState được gọi
  }

  Future<void> loadData() async {
    // Simulate loading data
    await Future.delayed(Duration(seconds: 1));

    // Dữ liệu đã được tải xong, cập nhật trạng thái và rebuild UI
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: dataLoading, // Sử dụng biến đã khai báo trong initState
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(), // Hiển thị biểu tượng loading
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: WebView(
                initialUrl: 'https://baotainguyenmoitruong.vn',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          );
        }
      },
    );
  }
}

class SecondScreen extends StatelessWidget {
  List<Map<String, dynamic>> itemList = [
    {
      'title': "LÊN LỊCH KIỂM TRA THIẾT BỊ QUAN TRẮC",
      'icon': Icons.star,
    },
    {
      'title': "THEO DÕI LỊCH BẢO TRÌ THIẾT BỊ QUAN ",
      'icon': Icons.favorite,
    },
    {
      'title': "ĐỔI LỊCH BẢO TRÌ THIẾT BỊ QUAN TRẮC",
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
                          } else if (itemData['title'] ==
                              "THEO DÕI LỊCH BẢO TRÌ THIẾT BỊ QUAN ") {
                            navigateToDataDisplayScreen(context);
                            // Thực hiện hành động liên quan đến Customer service
                          } else if (itemData['title'] ==
                              "ĐỔI LỊCH BẢO TRÌ THIẾT BỊ QUAN TRẮC") {
                            nagvigateToThirdScreenPro(context);
                          } else if (itemData['title'] == "UNDER DEVELOPMENT") {
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

  void nagvigateToThirdScreenPro(BuildContext context) {
    User? user =
        FirebaseAuth.instance.currentUser; // Lấy đối tượng người dùng hiện tại
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            DataEditScreen(user: user!), // Truyền đối tượng người dùng vào đây
      ),
    );
  }

  void onTapArrowleft(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FilterScreen(), // Truyền đối tượng người dùng vào đây
      ),
    );
  }
}

class ThirdScreen extends StatefulWidget {
  final String userEmail;

  ThirdScreen({required this.userEmail});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late Future<DocumentSnapshot<Map<String, dynamic>>> userData;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Future<void> handleLogoutButton(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('email');
    Get.to(SignInScreen());
    signOut();

    // Sau khi đăng xuất, chuyển hướng người dùng về màn hình đăng nhập hoặc màn hình chính
    // Dưới đây là ví dụ về cách bạn có thể chuyển hướng về màn hình đăng nhập:
    Navigator.pushReplacementNamed(context, AppRoutes.signInScreen);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.gray50,
            body: SingleChildScrollView(
              child: Container(
                  width: double.maxFinite,
                  padding: getPadding(left: 24, top: 32, right: 24, bottom: 32),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: getSize(70),
                            width: getSize(70),
                            child: Stack(
                                alignment: Alignment.bottomRight,
                                children: [
                                  CustomImageView(
                                      imagePath:
                                          ImageConstant.imgRectangle36170x70,
                                      height: getSize(70),
                                      width: getSize(70),
                                      radius: BorderRadius.circular(
                                          getHorizontalSize(35)),
                                      alignment: Alignment.center),
                                  CustomIconButton(
                                      height: 24,
                                      width: 24,
                                      variant:
                                          IconButtonVariant.OutlineBluegray50_2,
                                      shape: IconButtonShape.RoundedBorder10,
                                      padding: IconButtonPadding.PaddingAll5,
                                      alignment: Alignment.bottomRight,
                                      onTap: () {
                                        onTapBtnEdit(context);
                                      },
                                      child: CustomImageView(
                                          svgPath: ImageConstant.imgEdit12x12))
                                ])),
                        Padding(
                          padding: getPadding(top: 8),
                          child: FutureBuilder<User?>(
                            future:
                                FirebaseAuth.instance.authStateChanges().first,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(); // Hiển thị biểu tượng loading trong quá trình lấy thông tin người dùng
                              } else if (snapshot.hasData) {
                                // Người dùng đã đăng nhập, hiển thị email
                                return Text(
                                  "${snapshot.data!.email}",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtManropeBold18.copyWith(
                                      letterSpacing: getHorizontalSize(0.2)),
                                );
                              } else {
                                // Người dùng chưa đăng nhập, không hiển thị email
                                return Text(
                                  "Chưa đăng nhập",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtManropeBold18.copyWith(
                                      letterSpacing: getHorizontalSize(0.2)),
                                );
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: getPadding(top: 4),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(top: 31),
                                child: Text("Thông tin người dùng",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtManropeExtraBold14Bluegray500
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.2))))),
                        GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding: getPadding(top: 15),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              svgPath:
                                                  ImageConstant.imgInstagram)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 12, bottom: 7),
                                          child: Text(
                                              "Đổi thông tin người dùng",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                    ]))),
                        GestureDetector(
                            onTap: () {},
                            child: Padding(
                                padding: getPadding(top: 16),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconButton(
                                          height: 40,
                                          width: 40,
                                          variant:
                                              IconButtonVariant.FillBluegray50,
                                          shape:
                                              IconButtonShape.RoundedBorder10,
                                          padding:
                                              IconButtonPadding.PaddingAll12,
                                          child: CustomImageView(
                                              svgPath: ImageConstant.imgFile)),
                                      Padding(
                                          padding: getPadding(
                                              left: 16, top: 10, bottom: 9),
                                          child: Text("Lịch sử đăng nhập",
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle
                                                  .txtManropeSemiBold14Gray900)),
                                      Spacer(),
                                    ]))),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                                padding: getPadding(top: 32),
                                child: Text("Tài khoản",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle
                                        .txtManropeExtraBold14Bluegray500
                                        .copyWith(
                                            letterSpacing:
                                                getHorizontalSize(0.2))))),
                        Padding(
                            padding: getPadding(top: 16),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomIconButton(
                                      height: 40,
                                      width: 40,
                                      variant: IconButtonVariant.FillBluegray50,
                                      shape: IconButtonShape.RoundedBorder10,
                                      padding: IconButtonPadding.PaddingAll12,
                                      child: CustomImageView(
                                          svgPath: ImageConstant.imgMenu1)),
                                  Padding(
                                      padding: getPadding(
                                          left: 16, top: 12, bottom: 7),
                                      child: Text("Đổi mật khẩu",
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: AppStyle
                                              .txtManropeSemiBold14Gray900)),
                                  Spacer(),
                                ])),
                        Container(
                          child: GestureDetector(
                              onTap: () {
                                handleLogoutButton(context);
                              },
                              child: Padding(
                                  padding: getPadding(top: 16, bottom: 5),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomIconButton(
                                            height: 40,
                                            width: 40,
                                            variant: IconButtonVariant
                                                .FillBluegray50,
                                            shape:
                                                IconButtonShape.RoundedBorder10,
                                            padding:
                                                IconButtonPadding.PaddingAll12,
                                            child: CustomImageView(
                                              svgPath: ImageConstant.imgLogOut,
                                              color: Colors.blue,
                                            )),
                                        Padding(
                                            padding: getPadding(
                                                left: 16, top: 12, bottom: 7),
                                            child: Text("Đăng xuất",
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtManropeSemiBold14Gray900)),
                                        Spacer(),
                                      ]))),
                        )
                      ])),
            )));
  }

  onTapBtnEdit(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.editProfileScreen);
  }

  onTapRowinstagram(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.recentlyViewsScreen);
  }

  onTapMyfavorites(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.favoriteScreen);
  }

  onTapPasttour(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pastToursScreen);
  }

  onTapMylistings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homeListingScreen);
  }

  onTapSettings(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.settingsScreen);
  }

  onTapArrowleft15(BuildContext context) {
    Navigator.pop(context);
  }
}
