import 'package:aokiji_s_application4/core/app_export.dart';
import 'package:aokiji_s_application4/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OptionsItemWidget extends StatelessWidget {
  OptionsItemWidget({this.onTapColumnplay});

  VoidCallback? onTapColumnplay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapColumnplay?.call();
      },
      child: Container(
        padding: getPadding(
          left: 20,
          top: 26,
          right: 20,
          bottom: 26,
        ),
        decoration: AppDecoration.fillWhiteA700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconButton(
              height: 35,
              width: 35,
              variant: IconButtonVariant.FillBlue500,
              child: CustomImageView(
                svgPath: ImageConstant.imgClock,
              ),
            ),
            Container(
              width: getHorizontalSize(
                62,
              ),
              margin: getMargin(
                top: 19,
              ),
              child: Text(
                "",
                maxLines: null,
                textAlign: TextAlign.left,
                style: AppStyle.txtOverpassBold20,
              ),
            ),
            Padding(
              padding: getPadding(
                top: 10,
                bottom: 3,
              ),
              child: Text(
                "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtOverpassRegular15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
