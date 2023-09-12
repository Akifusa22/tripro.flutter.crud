import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MessageItemWidget extends StatelessWidget {
  MessageItemWidget({this.onTaptf});

  VoidCallback? onTaptf;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTaptf?.call();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: getSize(
              48,
            ),
            width: getSize(
              48,
            ),
            margin: getMargin(
              top: 1,
              bottom: 2,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImg48x481,
                  height: getSize(
                    48,
                  ),
                  width: getSize(
                    48,
                  ),
                  radius: BorderRadius.circular(
                    getHorizontalSize(
                      24,
                    ),
                  ),
                  alignment: Alignment.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: getSize(
                      12,
                    ),
                    width: getSize(
                      12,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.green500,
                      borderRadius: BorderRadius.circular(
                        getHorizontalSize(
                          6,
                        ),
                      ),
                      border: Border.all(
                        color: ColorConstant.gray50,
                        width: getHorizontalSize(
                          1,
                        ),
                        strokeAlign: strokeAlignOutside,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: getPadding(
              left: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  style: AppStyle.txtManropeBold16.copyWith(
                    letterSpacing: getHorizontalSize(
                      0.2,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 9,
                  ),
                  child: Text(
                    "",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtManropeMedium14Bluegray500,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: getPadding(
              top: 1,
              bottom: 30,
            ),
            child: Text(
              "",
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtManropeRegular14,
            ),
          ),
        ],
      ),
    );
  }
}
