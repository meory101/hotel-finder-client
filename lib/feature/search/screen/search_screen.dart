import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: AppWidthManager.w3Point8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppHeightManager.h8,),
              Container(
                padding: EdgeInsets.only(
                  left: AppWidthManager.w3Point8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadiusManager.r50),
                    color:AppColorManager.blackShadow),
                child: TextFormField(
                  style: TextStyle(
                      color: AppColorManager.white,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSizeManager.fs15),
                  cursorColor: AppColorManager.white,
                  decoration: InputDecoration(
                    hintText: "Search Places",
                    hintStyle: TextStyle(
                        color: AppColorManager.white,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSizeManager.fs15),
                    suffixIcon: SizedBox(
                      width: AppWidthManager.w5,
                      height: AppWidthManager.w5,
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppWidthManager.w4point3),
                          child: const Icon(
                            Icons.search,
                            color: AppColorManager.white,
                          )),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
