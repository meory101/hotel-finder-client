import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/core/api/api_links.dart';
import 'package:hotel_finder_client/core/storage/shared/shared_pref.dart';

import '../../../core/api/api_methods.dart';
import '../../../core/helper/language_helper.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;

import '../../../router/router.dart';
class RoomDetails extends StatefulWidget {
  final RoomDetailsArgs args;

  const RoomDetails({super.key, required this.args});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  void initState() {
    super.initState();
  }

  int selectedindex = 0;
  DateTime? dateTime;
  onBookNowClicked()async{
    if(dateTime==null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: "Please select date",
                  color: AppColorManager.white,
                  fontSize: FontSizeManager.fs14,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.visible,
                ),
              ],
            )),
      );
      return;
    }
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
    http.Response response = await HttpMethods().postMethod(ApiPostUrl.reserveRoom, {
      "date": dateTime.toString(),
      "nights": "${selectedindex+1}",
      "user_id": AppSharedPreferences.getUserId(),
      "room_id": widget.args.roomData['room']['id'].toString(),
    });
    var body = jsonDecode(response.body);
    print(body);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: "Please wait until the hotel accept your reservation",
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
    );  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      floatingActionButton:
       Padding(
        // color: AppColorManager.white,
        padding: EdgeInsets.all(AppWidthManager.w3Point8),
        child: MainAppButton(
          alignment: Alignment.center,
          padding: EdgeInsets.only(
              left: AppWidthManager.w6, right: AppWidthManager.w3),
          borderRadius: BorderRadius.circular(AppRadiusManager.r50),
          width: AppWidthManager.w100,
          height: AppHeightManager.h8,
          color: AppColorManager.blackShadow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTextWidget(
                    text: 'room price',
                    fontSize: FontSizeManager.fs13,
                    fontWeight: FontWeight.w600,
                    color: AppColorManager.greyWithOpacity6,
                  ),
                  AppTextWidget(
                    text: '${widget.args.roomData['room']['price']}\$',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: AppHeightManager.h05,
                  )
                ],
              ),
              MainAppButton(
                onTap: onBookNowClicked,
                alignment: Alignment.center,
                color: AppColorManager.white,
                width: AppWidthManager.w35,
                height: AppHeightManager.h6,
                borderRadius: BorderRadius.circular(AppRadiusManager.r50),
                child: AppTextWidget(
                  text: 'Book Now',
                  fontSize: FontSizeManager.fs16,
                  fontWeight: FontWeight.w700,
                  color: AppColorManager.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadiusManager.r30),
                  bottomRight: Radius.circular(
                    AppRadiusManager.r30,
                  ),
                ),
              ),
              height: AppHeightManager.h50,
              child: MainImageWidget(
                fit: BoxFit.cover,
                imageUrl: '${imageUrl}' +
                    '${widget.args.roomData['image'].first['image']}',
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppWidthManager.w3Point8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AppTextWidget(
                            text: widget.args.roomData['room']['name'],
                            fontSize: FontSizeManager.fs18,
                            fontWeight: FontWeight.w700,
                            color: AppColorManager.textAppColor,
                          ),
                          SizedBox(
                            width: AppWidthManager.w1,
                          ),
                          AppTextWidget(
                            text:
                                '(${widget.args.roomData['room']['capacity']} People)',
                            fontSize: FontSizeManager.fs15,
                            fontWeight: FontWeight.w600,
                            color: AppColorManager.textAppColor,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: AppHeightManager.h2,
                            width: AppHeightManager.h2,
                            child: SvgPicture.asset(AppIconManager.star),
                          ),
                          AppTextWidget(
                            text: '${widget.args.roomData['rate'] ?? ""} star',
                            fontSize: FontSizeManager.fs15,
                            fontWeight: FontWeight.w800,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppTextWidget(
                        text: widget.args.roomData['room']['desc'],
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w600,
                        color: AppColorManager.textGrey,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: AppWidthManager.w2,
                      ),
                      AppTextWidget(
                        text: widget.args.roomData['room']['price'].toString(),
                        fontSize: FontSizeManager.fs15,
                        fontWeight: FontWeight.w800,
                        color: AppColorManager.textAppColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  Container(
                    width: AppWidthManager.w100,
                    height: AppHeightManager.h05,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColorManager.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  AppTextWidget(
                    text: 'Room View',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1,
                  ),
                  Wrap(
                    children: List.generate(
                        widget.args.roomData['vnames'].length, (i) {
                      return MainAppButton(
                        margin: EdgeInsets.only(right: AppWidthManager.w2,bottom: AppHeightManager.h1),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w3Point8,
                            vertical: AppHeightManager.h02),
                        color: AppColorManager.greyWithOpacity6,
                        child: AppTextWidget(
                          text: widget.args.roomData['vnames'][i]['name'] +
                              ' view',
                          fontSize: FontSizeManager.fs15,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.textGrey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  Container(
                    width: AppWidthManager.w100,
                    height: AppHeightManager.h05,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColorManager.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  AppTextWidget(
                    text: 'Room Tools',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1,
                  ),
                  Wrap(
                    children: List.generate(
                        widget.args.roomData['tnames'].length, (i) {
                      return MainAppButton(
                        margin: EdgeInsets.only(right: AppWidthManager.w2,bottom: AppHeightManager.h1),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppWidthManager.w3Point8,
                            vertical: AppHeightManager.h02),
                        color: AppColorManager.greyWithOpacity6,
                        child: AppTextWidget(
                          text: widget.args.roomData['tnames'][i]['name'] + ' ',
                          fontSize: FontSizeManager.fs15,
                          fontWeight: FontWeight.w600,
                          color: AppColorManager.textGrey,
                        ),
                      );
                    }),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  Container(
                    width: AppWidthManager.w100,
                    height: AppHeightManager.h05,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColorManager.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  AppTextWidget(
                    text: 'Nights',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1,
                  ),
                  SizedBox(
                    height: AppWidthManager.w14,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return MainAppButton(
                          onTap: () {
                            setState(() {
                              selectedindex = index;
                            });
                          },
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.only(right: AppWidthManager.w3Point8),
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r10),
                          width: AppWidthManager.w10,
                          height: AppWidthManager.w14,
                          color: index == selectedindex
                              ? AppColorManager.blackShadow
                              : AppColorManager.shadow,
                          child: AppTextWidget(
                            text: '${index + 1}',
                            // fontWeight: FontWeight.w7000,
                            color: selectedindex == index
                                ? AppColorManager.white
                                : AppColorManager.blackShadow,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  Container(
                    width: AppWidthManager.w100,
                    height: AppHeightManager.h05,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColorManager.buttonColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h2,
                  ),
                  AppTextWidget(
                    text: 'Date',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: AppHeightManager.h1,
                  ),
                  InkWell(
                    onTap: () {
                      DateTime selectedDate = DateTime(DateTime.now().year - 12);
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppColorManager.white,
                        builder: (BuildContext builder) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                              color: AppColorManager.white,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: AppHeightManager.h30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                                    color: AppColorManager.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w5),
                                    child: CupertinoDatePicker(
                                      // initialDateTime: DateTime.now(),
                                      onDateTimeChanged: (DateTime? pickedDate) {
                                        if (pickedDate != null) {
                                          selectedDate = pickedDate;
                                        }
                                      },
                                      itemExtent: AppHeightManager.h5,

                                      mode: CupertinoDatePickerMode.date,
                                      use24hFormat: true,
                                      minimumDate: DateTime.now(),
                                      // maximumDate: DateTime(2028),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: AppHeightManager.h2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MainAppButton(
                                      width: MediaQuery.of(context).size.width / 2.6,
                                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                                      height: AppHeightManager.h5,
                                      onTap: () {
                                        Navigator.of(context).pop();

                                      },
                                      color: AppColorManager.blackShadow,
                                      alignment: Alignment.center,
                                      child: AppTextWidget(
                                        text: "save",
                                        fontSize: FontSizeManager.fs16,
                                        color: AppColorManager.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: AppWidthManager.w2,
                                    ),
                                    MainAppButton(
                                      width: MediaQuery.of(context).size.width / 2.6,
                                      borderRadius: BorderRadius.circular(AppRadiusManager.r10),
                                      height: AppHeightManager.h5,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      color: AppColorManager.white,
                                      alignment: Alignment.center,
                                      child: AppTextWidget(
                                        text: "cancel",
                                        fontSize: FontSizeManager.fs16,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: AppHeightManager.h2,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      alignment: LanguageHelper.checkIfLTR(context: context)
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      width: double.infinity,
                      height: AppHeightManager.h6,
                      decoration: BoxDecoration(
                        color: AppColorManager.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(AppRadiusManager.r10)),
                        border: Border.all(
                          color: AppColorManager.greyWithOpacity6,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppWidthManager.w3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppTextWidget(
                                text: (dateTime ?? "")
                                    .toString()
                                    .split(' ')
                                    .first
                                    .toString())
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppHeightManager.h10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomDetailsArgs {
  var roomData;

  RoomDetailsArgs({this.roomData});
}
