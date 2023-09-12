import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class List1ItemWidget extends StatelessWidget {
  List1ItemWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomImageView(
          imagePath: ImageConstant.imgImage109x102,
          height: getSize(
            171,
          ),
          width: getSize(
            171,
          ),
          radius: BorderRadius.circular(
            getHorizontalSize(
              8,
            ),
          ),
        ),
        Padding(
          padding: getPadding(
            top: 11,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Long ",
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: getFontSize(
                      13,
                    ),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                    letterSpacing: getHorizontalSize(
                      0.39,
                    ),
                  ),
                ),
                TextSpan(
                  text: "Sleeve T-shirt",
                  style: TextStyle(
                    color: ColorConstant.black900,
                    fontSize: getFontSize(
                      13,
                    ),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
