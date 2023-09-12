import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_iconbutton_1.dart';
import 'package:aokiji_s_application4/widgets/app_bar/appbar_subtitle.dart';
import 'package:aokiji_s_application4/widgets/app_bar/custom_app_bar.dart';
import 'package:aokiji_s_application4/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
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
                      onTapArrowleft15(context);
                    }),
                centerTitle: true,
                title: AppbarSubtitle(text: "Profile")),
            body: Container(
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
                          child: Text("Cameron Williamson",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManropeBold18.copyWith(
                                  letterSpacing: getHorizontalSize(0.2)))),
                      Padding(
                          padding: getPadding(top: 4),
                          child: Text("hello@gmail.com",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtManropeMedium14Bluegray500)),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 31),
                              child: Text("Home search",
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle
                                      .txtManropeExtraBold14Bluegray500
                                      .copyWith(
                                          letterSpacing:
                                              getHorizontalSize(0.2))))),
                      GestureDetector(
                          onTap: () {
                            onTapRowinstagram(context);
                          },
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
                                        shape: IconButtonShape.RoundedBorder10,
                                        padding: IconButtonPadding.PaddingAll12,
                                        child: CustomImageView(
                                            svgPath:
                                                ImageConstant.imgInstagram)),
                                    Padding(
                                        padding: getPadding(
                                            left: 16, top: 12, bottom: 7),
                                        child: Text("Recently viewed",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtManropeSemiBold14Gray900)),
                                    Spacer(),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightBlueGray500,
                                        height: getSize(20),
                                        width: getSize(20),
                                        margin: getMargin(top: 10, bottom: 10))
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            onTapMyfavorites(context);
                          },
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
                                        shape: IconButtonShape.RoundedBorder10,
                                        padding: IconButtonPadding.PaddingAll12,
                                        child: CustomImageView(
                                            svgPath: ImageConstant
                                                .imgLocation40x40)),
                                    Padding(
                                        padding: getPadding(
                                            left: 16, top: 12, bottom: 7),
                                        child: Text("My favorites",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtManropeSemiBold14Gray900)),
                                    Spacer(),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightBlueGray500,
                                        height: getSize(20),
                                        width: getSize(20),
                                        margin: getMargin(top: 10, bottom: 10))
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            onTapPasttour(context);
                          },
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
                                        shape: IconButtonShape.RoundedBorder10,
                                        padding: IconButtonPadding.PaddingAll12,
                                        child: CustomImageView(
                                            svgPath: ImageConstant.imgFile)),
                                    Padding(
                                        padding: getPadding(
                                            left: 16, top: 10, bottom: 9),
                                        child: Text("Past Tour",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtManropeSemiBold14Gray900)),
                                    Spacer(),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightBlueGray500,
                                        height: getSize(20),
                                        width: getSize(20),
                                        margin: getMargin(top: 10, bottom: 10))
                                  ]))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(top: 32),
                              child: Text("General",
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
                                    child: Text("Sell my home",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle
                                            .txtManropeSemiBold14Gray900)),
                                Spacer(),
                                CustomImageView(
                                    svgPath:
                                        ImageConstant.imgArrowrightBlueGray500,
                                    height: getSize(20),
                                    width: getSize(20),
                                    margin: getMargin(top: 10, bottom: 10))
                              ])),
                      GestureDetector(
                          onTap: () {
                            onTapMylistings(context);
                          },
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
                                        shape: IconButtonShape.RoundedBorder10,
                                        padding: IconButtonPadding.PaddingAll12,
                                        child: CustomImageView(
                                            svgPath:
                                                ImageConstant.imgHome44x44)),
                                    Padding(
                                        padding: getPadding(
                                            left: 16, top: 12, bottom: 7),
                                        child: Text("My listings ",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtManropeSemiBold14Gray900)),
                                    Spacer(),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightBlueGray500,
                                        height: getSize(20),
                                        width: getSize(20),
                                        margin: getMargin(top: 10, bottom: 10))
                                  ]))),
                      GestureDetector(
                          onTap: () {
                            onTapSettings(context);
                          },
                          child: Padding(
                              padding: getPadding(top: 16, bottom: 5),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomIconButton(
                                        height: 40,
                                        width: 40,
                                        variant:
                                            IconButtonVariant.FillBluegray50,
                                        shape: IconButtonShape.RoundedBorder10,
                                        padding: IconButtonPadding.PaddingAll12,
                                        child: CustomImageView(
                                            svgPath:
                                                ImageConstant.imgSettings1)),
                                    Padding(
                                        padding: getPadding(
                                            left: 16, top: 12, bottom: 7),
                                        child: Text("Settings",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.left,
                                            style: AppStyle
                                                .txtManropeSemiBold14Gray900)),
                                    Spacer(),
                                    CustomImageView(
                                        svgPath: ImageConstant
                                            .imgArrowrightBlueGray500,
                                        height: getSize(20),
                                        width: getSize(20),
                                        margin: getMargin(top: 10, bottom: 10))
                                  ])))
                    ]))));
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
