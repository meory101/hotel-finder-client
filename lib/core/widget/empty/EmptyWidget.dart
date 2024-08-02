import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../image/main_image_widget.dart';
import '../text/app_text_widget.dart';

class EmptyWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? image;
  final Widget? actions;

  const EmptyWidget({this.image, this.subTitle, this.title, this.actions});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: image != null,
      replacement: const SizedBox(),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MainImageWidget(
              height: AppWidthManager.w70,
              width: AppWidthManager.w70,
              fit: BoxFit.cover,
              imagePath: image,
            ),
            SizedBox(
              height: AppHeightManager.h1point8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextWidget(
                    text: title ?? "",
                    fontSize: FontSizeManager.fs18,
                    fontWeight: FontWeight.w700,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: AppHeightManager.h05,
                  ),
                  AppTextWidget(
                    text: subTitle ?? "",
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w400,
                    color: AppColorManager.grey,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1point5,
                  ),
                  Visibility(
                    visible: actions != null,
                    child: Column(
                      children: [
                        SizedBox(
                          height: AppHeightManager.h1point8,
                        ),
                        actions ?? const SizedBox(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
