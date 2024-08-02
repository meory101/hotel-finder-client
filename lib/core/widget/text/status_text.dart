import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import 'app_text_widget.dart';

class FlexStatusText extends StatelessWidget {
  const FlexStatusText(
      {super.key,
      required this.color,
      required this.text,
      this.fontSize,
      this.alignment});

  final String text;
  final Color color;
  final double? fontSize;
  final MainAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: AppHeightManager.h1,
            width: AppHeightManager.h1,
            margin: EdgeInsets.only(top: AppHeightManager.h02),
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          SizedBox(
            width: AppWidthManager.w05,
          ),
          Flexible(
            child: AppTextWidget(
              text: text,
              color: color,
              fontWeight: FontWeight.w700,
              fontSize: fontSize ?? FontSizeManager.fs15,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusText extends StatelessWidget {
  const StatusText(
      {super.key,
      required this.color,
      required this.text,
      this.fontSize,
      this.alignment});

  final String text;
  final Color color;
  final double? fontSize;
  final MainAxisAlignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: alignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Container(
          height: AppHeightManager.h1,
          width: AppHeightManager.h1,
          margin: EdgeInsets.only(top: AppHeightManager.h02),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(
          width: AppWidthManager.w1,
        ),
        Flexible(
          child: AppTextWidget(
            text: text,
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: fontSize ?? FontSizeManager.fs15,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
