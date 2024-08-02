import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/core/resource/size_manager.dart';
import 'package:hotel_finder_client/core/widget/button/main_app_button.dart';
import 'package:hotel_finder_client/core/widget/form_field/title_app_form_filed.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/storage/shared/shared_pref.dart';
import '../../../core/widget/text/app_text_widget.dart';
import '../../../router/router.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> fkey = GlobalKey();

  void onSignUpClicked() {
    Navigator.of(context).pushNamed(RouteNamedScreens.register);
  }

  void SignInClicked() async {
    if (!fkey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: AppHeightManager.h2,
            width: AppHeightManager.h2,
            child: CircularProgressIndicator(
              color: AppColorManager.red,
            ),
          ),
        ],
      )),
    );
    http.Response response = await HttpMethods().postMethod(ApiPostUrl.login, {
      "email": email.text,
      "password": password.text,
    });
    var body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      AppSharedPreferences.cashUserName(username: body['use data']['name']);
      AppSharedPreferences.cashUserid(id: body['use data']['id'].toString());
      AppSharedPreferences.cashUserToken(token: body['token']);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: "Welcome Back",
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
      Navigator.of(context).pushNamed(RouteNamedScreens.bottomAppBar);

      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppTextWidget(
          text: body,
          color: AppColorManager.white,
          fontSize: FontSizeManager.fs14,
          fontWeight: FontWeight.w700,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: fkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.75,
                width: AppWidthManager.w100,
                decoration: const BoxDecoration(),
                child: SvgPicture.asset("assets/icons/curve.svg"),
              ),
              Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppHeightManager.h1,
                    ),
                    AppTextWidget(
                      text: "Sign In.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs20,
                      fontWeight: FontWeight.w800,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h05,
                    ),
                    AppTextWidget(
                      text: "Sign In To Your Registered Account.",
                      color: AppColorManager.black,
                      fontSize: FontSizeManager.fs16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    Container(
                      width: AppWidthManager.w10,
                      color: Colors.black,
                      height: AppHeightManager.h05,
                    ),
                    SizedBox(
                      height: AppHeightManager.h5,
                    ),
                    TitleAppFormFiled(
                      hint: "Email Address",
                      title: "Email Address",
                      onChanged: (value) {
                        return null;
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    TitleAppFormFiled(
                      hint: "Password",
                      title: "Password",
                      onChanged: (value) {
                        return null;
                      },
                      validator: (value) {
                        return null;
                      },
                    ),
                    SizedBox(
                      height: AppHeightManager.h8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MainAppButton(
                          onTap: SignInClicked,
                          alignment: Alignment.center,
                          width: AppWidthManager.w30,
                          height: AppHeightManager.h5,
                          color: AppColorManager.black,
                          child: AppTextWidget(
                            text: "Sign In",
                            color: AppColorManager.white,
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                        SizedBox(
                          width: AppWidthManager.w5,
                        ),
                        MainAppButton(
                          onTap: onSignUpClicked,
                          outLinedBorde: true,
                          borderColor: AppColorManager.black,
                          alignment: Alignment.center,
                          width: AppWidthManager.w30,
                          height: AppHeightManager.h5,
                          color: AppColorManager.white,
                          child: AppTextWidget(
                            text: "Sign Up",
                            color: AppColorManager.black,
                            fontSize: FontSizeManager.fs14,
                            fontWeight: FontWeight.w600,
                            overflow: TextOverflow.visible,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
