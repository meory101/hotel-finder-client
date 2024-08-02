import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class LanguageHelper {
  static bool checkIfLTR({required BuildContext context}) {
    return Directionality.of(context) == TextDirection.ltr;
  }

  static bool isEnglishData(
      {required BuildContext context, required String data}) {
    if (data.isEmpty) return checkIfLTR(context: context);

    data = data.replaceAll(RegExp(r'[^\w\u0600-\u06FF\s]'), '');

    bool isOk = data.trim().startsWith(RegExp(r'[A-Za-z]'), 0);

    return isOk;
  }
}
