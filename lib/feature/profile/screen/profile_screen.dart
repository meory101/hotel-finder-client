import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hotel_finder_client/core/helper/post_with_file_helper.dart';
import 'package:hotel_finder_client/core/storage/shared/shared_pref.dart';
import 'package:hotel_finder_client/core/widget/image/main_image_widget.dart';
import 'package:hotel_finder_client/router/router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/drop_down/NameAndId.dart';
import '../../../core/widget/form_field/title_app_form_filed.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

File? image;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int status = 0;
  var profileData;
  String? name;

  String? gender;
  String? number;

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getProfile() async {
    setState(() {
      status = 0;
    });
    http.Response response =
        await HttpMethods().getMethod('${ApiGetUrl.getUserProfile}${AppSharedPreferences.getUserId()}');

    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });

      profileData = jsonDecode(response.body);
      print(profileData);
    } else {
      setState(() {
        status = 2;
      });
    }
    setState(() {});
  }

  updateProfile() async {
    setState(() {
      status = 0;
    });
    var data = {
      'name': name ?? "",
      'gender': gender ?? "",
      'number': number ?? "",
      'id': AppSharedPreferences.getUserId(),
    };

    http.Response response =
        await HttpMethods().postMethod(ApiPostUrl.updateUserProfile, data);

    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });
      getProfile();
    } else {
      setState(() {
        status = 2;
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.red,
      onRefresh: () {
        return getProfile();
      },
      child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: status == 0
              ? Container(
                  padding: EdgeInsets.all(AppWidthManager.w3Point8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppHeightManager.h8,
                      ),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: AppWidthManager.w25,
                        width: AppWidthManager.w25,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const MainImageWidget(
                          imageUrl: '',
                        ),
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      Container(
                        height: AppHeightManager.h6,
                        width: AppWidthManager.w100,
                        decoration: BoxDecoration(
                            color: AppColorManager.shimmerBaseColor,
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r10)),
                      ),
                      SizedBox(
                        height: AppHeightManager.h1point8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: AppHeightManager.h6,
                              width: AppWidthManager.w100,
                              decoration: BoxDecoration(
                                  color: AppColorManager.shimmerBaseColor,
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r10)),
                            ),
                          ),
                          SizedBox(
                            width: AppWidthManager.w3Point8,
                          ),
                          Expanded(
                            child: Container(
                              height: AppHeightManager.h6,
                              width: AppWidthManager.w100,
                              decoration: BoxDecoration(
                                  color: AppColorManager.shimmerBaseColor,
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r10)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppHeightManager.h7,
                      ),
                      Container(
                        height: AppHeightManager.h6,
                        width: AppWidthManager.w100,
                        decoration: BoxDecoration(
                            color: AppColorManager.shimmerBaseColor,
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r10)),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppWidthManager.w3Point8),
                  child:

                  Form(
                    // key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: AppHeightManager.h9,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: AppWidthManager.w25,
                                  width: AppWidthManager.w25,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle),
                                  child: image == null
                                      ? const MainImageWidget(
                                          imageUrl: '',
                                        )
                                      : Container(
                                          clipBehavior:
                                              Clip.antiAliasWithSaveLayer,
                                          alignment: Alignment.center,
                                          height: AppHeightManager.h13,
                                          width: AppHeightManager.h13,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColorManager
                                                      .greyWithOpacity6,
                                                  offset: const Offset(
                                                    -2,
                                                    2,
                                                  ),
                                                  blurRadius: 4,
                                                  spreadRadius: 4)
                                            ],
                                            color: AppColorManager
                                                .shimmerBaseColor,
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: FileImage(
                                                image ?? File(""),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                ),
                                Positioned(
                                  bottom: AppHeightManager.h1point5,
                                  left: AppWidthManager.w18,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () async {
                                      final ImagePicker _picker = ImagePicker();

                                      final XFile? img =
                                          await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        maxHeight: 512,
                                        maxWidth: 512,
                                        imageQuality: 75,
                                      );
                                      image = File(img?.path ?? "");
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      padding:
                                          EdgeInsets.all(AppWidthManager.w1),
                                      decoration: const BoxDecoration(
                                          color: AppColorManager.textAppColor,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.edit,
                                        color: AppColorManager.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: AppHeightManager.h4,
                              ),
                              child: MainAppButton(
                                onTap: () {
                                  AppSharedPreferences.clear();
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      RouteNamedScreens.login,
                                      (route) => false);
                                },
                                color: AppColorManager.blackShadow,
                                height: AppWidthManager.w8,
                                width: AppWidthManager.w8,
                                child:  const Icon(
                                    Icons.logout,
                                    size: 15,
                                    color: AppColorManager.white,

                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h2,
                        ),
                        TitleAppFormFiled(
                          initValue:
                              profileData == null ? "" : profileData['name'],
                          isRequired: true,
                          hint: "name",
                          title: "name",
                          validator: (value) {
                            if ((value ?? "").isEmpty) {
                              return "emptyFiled";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value ?? "";
                            return value;
                          },
                        ),
                        SizedBox(
                          height: AppHeightManager.h2point5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextWidget(
                                    text: "gender",
                                    fontSize: FontSizeManager.fs16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: AppHeightManager.h1point5,
                                  ),
                                  MainDropdownWidget(
                                    hint: profileData['gender'] ??
                                             "gender",
                                    options: const [
                                      NameAndId(name: 'male', id: "0"),
                                      NameAndId(name: 'female', id: "1"),
                                    ],
                                    onChanged: (value) {
                                      gender = value?.name;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: AppWidthManager.w2,
                            ),
                            Expanded(
                                child: TitleAppFormFiled(
                              initValue: profileData['number'] ?? "",
                              isRequired: true,
                              hint: "number",
                              title: "number",
                              validator: (value) {
                                if ((value ?? "").isEmpty) {
                                  return "emptyFiled";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                number = value ?? "";
                                return value;
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: AppHeightManager.h4,
                        ),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            color: AppColorManager.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: AppHeightManager.h2point5),
                            child:

                            MainAppButton(
                              onTap: () {
                                updateProfile();
                              },
                              height: AppHeightManager.h6,
                              alignment: Alignment.center,
                              color: AppColorManager.black,
                              borderRadius:
                                  BorderRadius.circular(AppRadiusManager.r15),
                              child: AppTextWidget(
                                  text: "save",
                                  color: AppColorManager.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSizeManager.fs16),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}
