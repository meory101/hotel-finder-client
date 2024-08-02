
import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../helper/language_helper.dart';
import '../../resource/color_manager.dart';
import '../../resource/font_manager.dart';
import '../../resource/size_manager.dart';
import '../container/decorated_container.dart';
import '../text/app_text_widget.dart';

class NameAndId {
  final String name;
  final String id;
  final String data;

  const NameAndId({required this.name, required this.id, this.data = ''});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NameAndId &&
        other.name == name &&
        other.id == id &&
        other.data == data;
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ data.hashCode;
}

class MainDropdownWidget extends StatefulWidget {
  const MainDropdownWidget({
    Key? key,
    required this.options,
    required this.hint,
    this.hintFontColor,
    this.hintFontSize,
    this.hintFontWeight,
    this.reset,
    this.iconColor,
    this.width,
    this.iconSize,
    this.borderColor,
    this.value,
    this.onChanged,
  }) : super(key: key);
  final List<NameAndId> options;
  final String hint;
  final bool? reset;
  final Color? hintFontColor;
  final FontWeight? hintFontWeight;
  final double? hintFontSize;
  final NameAndId? value;
  final Color? borderColor;
  final double? width;
  final double? iconSize;
  final Color? iconColor;
  final Function(NameAndId?)? onChanged;

  @override
  State<MainDropdownWidget> createState() => _MainDropdownWidgetState();
}

class _MainDropdownWidgetState extends State<MainDropdownWidget> {
  NameAndId? nameAndIdObject;

  @override
  void didUpdateWidget(covariant MainDropdownWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.options != widget.options) {
      setState(() {
        nameAndIdObject = null;
      });
    }
  }

  GlobalKey<FormFieldState> dropDownKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return DecoratedContainer(
      width: widget.width ?? widget.width,
      border: Border.all(
        color:widget.borderColor?? AppColorManager.greyWithOpacity6,

      ),
      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
      boxShadow: const [],
      height: AppHeightManager.h6,
      padding: EdgeInsets.only(
        left: LanguageHelper.checkIfLTR(context: context)
            ? AppWidthManager.w05
            : AppWidthManager.w3Point8,
        right: LanguageHelper.checkIfLTR(context: context)
            ? AppWidthManager.w3Point8
            : AppWidthManager.w05,
      ),
      child: DropdownButton2<NameAndId>(
        key: dropDownKey,
        isExpanded: true,
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusManager.r10),
          ),
        ),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadiusManager.r10),
          ),
        ),
        style: TextStyle(
            fontWeight: widget.hintFontWeight ?? FontWeight.w400,
            fontFamily: FontFamilyManager.cairo,
            color: AppColorManager.textAppColor,
            fontSize: FontSizeManager.fs16),
        items: widget.options
            .map((option) => DropdownMenuItem<NameAndId>(
                  value: option,
                  child: AppTextWidget(
                    color: AppColorManager.black,
                    text: option.name,
                    fontSize: FontSizeManager.fs15,
                  ),
                ))
            .toList(),
        hint: AppTextWidget(
          text: widget.hint,
          fontSize: widget.hintFontSize ?? FontSizeManager.fs15,
          overflow: TextOverflow.fade,
          color: widget.hintFontColor ?? AppColorManager.grey,
        ),
        underline: const SizedBox(),
        onChanged: (value) {
          setState(() {
            nameAndIdObject = value;
          });
          widget.onChanged!(value);
        },
        iconStyleData:  IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color:widget.iconColor ?? AppColorManager.black,
            size: widget.iconSize ?? AppHeightManager.h3,
          ),
        ),
        value: widget.value ?? nameAndIdObject,
      ),
    );
  }
}
