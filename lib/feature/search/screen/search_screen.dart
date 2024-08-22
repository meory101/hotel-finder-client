import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/core/widget/form_field/app_form_field.dart';
import 'package:hotel_finder_client/core/widget/text/app_text_widget.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/image_manager.dart';
import '../../../core/resource/size_manager.dart';
import 'package:http/http.dart' as http;

import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/empty/EmptyWidget.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../router/router.dart';
import '../../home/screen/room_details.dart';

TextEditingController searchController = TextEditingController();

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int statusRoom = 2;
  var rooms;

  onRoomClicked(roomData) {
    Navigator.of(context).pushNamed(
      RouteNamedScreens.roomDetails,
      arguments: RoomDetailsArgs(
        roomData: roomData,
      ),
    );
  }

  getRooms() async {
    setState(() {
      statusRoom = 0;
    });
    http.Response response = await HttpMethods().postMethod(
        ApiPostUrl.getMostReleventRooms,
        {'searchQuery': searchController.text});
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      setState(() {
        statusRoom = 1;
      });

      rooms = jsonDecode(response.body);
      print(rooms);
      print('00000000000000000000000000000');
    } else {
      setState(() {
        statusRoom = 2;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppTextWidget(
            text: "Something Went Wrong",
            color: AppColorManager.white,
            fontSize: FontSizeManager.fs14,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.visible,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppWidthManager.w1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppHeightManager.h8,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppWidthManager.w1),
                height: AppHeightManager.h7,
                padding: EdgeInsets.only(
                  top: AppHeightManager.h05,
                  left: AppWidthManager.w3Point8,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadiusManager.r50),
                    color: AppColorManager.blackShadow),
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(
                      color: AppColorManager.white,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSizeManager.fs15),
                  cursorColor: AppColorManager.white,
                  decoration: InputDecoration(
                    hintText: "Search Places",
                    hintStyle: TextStyle(
                        color: AppColorManager.greyWithOpacity6,
                        fontWeight: FontWeight.w500,
                        fontSize: FontSizeManager.fs15),
                    suffixIcon: SizedBox(
                      width: AppWidthManager.w5,
                      height: AppWidthManager.w5,
                      child: InkWell(
                        overlayColor: MaterialStateProperty.all(
                            AppColorManager.transparent),
                        onTap: () {
                          getRooms();
                        },
                        child: Padding(
                            padding:
                                EdgeInsets.only(bottom: AppWidthManager.w1),
                            child: const Icon(
                              Icons.search,
                              color: AppColorManager.white,
                            )),
                      ),
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
              Visibility(
                visible: statusRoom == 1,
                child: Padding(
                  padding: EdgeInsets.all(AppWidthManager.w3Point8),
                  child: AppTextWidget(
                    text: "Most Relevant Rooms",
                    fontWeight: FontWeight.w700,
                    fontSize: FontSizeManager.fs18,
                    color: AppColorManager.black,
                  ),
                ),
              ),
              Visibility(
                visible: statusRoom == 1 && rooms != null && rooms.isEmpty,
                child: Padding(
                  padding: EdgeInsets.only(top: AppHeightManager.h6),
                  child: EmptyWidget(
                    image: AppImageManager.empty,
                    title: "Nothing Found.",
                    subTitle: "Please Try Again.",
                  ),
                ),
              ),
              Visibility(
                visible: statusRoom == 0,
                child: SizedBox(
                  height: AppHeightManager.h45,
                  width: double.infinity,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.only(
                            top: AppHeightManager.h1point5,
                            left: AppWidthManager.w3Point8,
                            right: AppWidthManager.w3Point8,
                            bottom: AppHeightManager.h1point8),
                        height: AppHeightManager.h45,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(AppRadiusManager.r30)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: AppHeightManager.h30,
                              child: MainImageWidget(
                                height: AppHeightManager.h40,
                                borderRadius:
                                    BorderRadius.circular(AppRadiusManager.r30),
                                fit: BoxFit.fill,
                                imageUrl: '',
                              ),
                            ),
                            SizedBox(
                              height: AppHeightManager.h2,
                            ),
                            Container(
                              height: AppHeightManager.h1point8,
                              width: AppWidthManager.w40,
                              decoration: BoxDecoration(
                                  color: AppColorManager.shimmerBaseColor,
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r30)),
                            ),
                            SizedBox(
                              height: AppHeightManager.h05,
                            ),
                            Container(
                              height: AppHeightManager.h1point8,
                              width: AppWidthManager.w60,
                              decoration: BoxDecoration(
                                  color: AppColorManager.shimmerBaseColor,
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r30)),
                            ),
                            SizedBox(
                              height: AppHeightManager.h05,
                            ),
                            Container(
                              height: AppHeightManager.h1point8,
                              width: AppWidthManager.w60,
                              decoration: BoxDecoration(
                                  color: AppColorManager.shimmerBaseColor,
                                  borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r30)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Visibility(
                visible: statusRoom == 1 && rooms != null,
                child: rooms == null
                    ? SizedBox()
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: rooms.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              onRoomClicked(rooms[index]);
                            },
                            child: Card(
                              surfaceTintColor: AppColorManager.transparent,
                              elevation: 4,
                              shadowColor: AppColorManager.greyWithOpacity1,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: AppWidthManager.w3Point8,
                                      right: AppWidthManager.w3Point8,
                                      bottom: AppHeightManager.h1point8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      AppRadiusManager.r30,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            AppWidthManager.w3Point8),
                                        height: AppHeightManager.h30,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              filterQuality: FilterQuality.high,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                '$imageUrl${rooms[index]['image'].first['image']}',
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppRadiusManager.r30)),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            AppWidthManager.w3Point8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    AppTextWidget(
                                                      text: rooms[index]['room']
                                                          ['name'],
                                                      fontSize:
                                                          FontSizeManager.fs16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColorManager
                                                          .textAppColor,
                                                    ),
                                                    SizedBox(
                                                      width: AppWidthManager.w1,
                                                    ),
                                                    AppTextWidget(
                                                      text:
                                                          '(${rooms[index]['room']['capacity']} People)',
                                                      fontSize:
                                                          FontSizeManager.fs14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColorManager
                                                          .textAppColor,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          AppHeightManager.h2,
                                                      width:
                                                          AppHeightManager.h2,
                                                      child: SvgPicture.asset(
                                                          AppIconManager.star),
                                                    ),
                                                    AppTextWidget(
                                                      text:
                                                          '${rooms[index]['rate'] ?? ""} star',
                                                      fontSize:
                                                          FontSizeManager.fs15,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.amber,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                AppTextWidget(
                                                  text: rooms[index]['room']
                                                      ['desc'],
                                                  fontSize:
                                                      FontSizeManager.fs15,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppColorManager.textGrey,
                                                  maxLines: 2,
                                                ),
                                                SizedBox(
                                                  width: AppWidthManager.w2,
                                                ),
                                                AppTextWidget(
                                                  text: rooms[index]['room']
                                                          ['price']
                                                      .toString(),
                                                  fontSize:
                                                      FontSizeManager.fs15,
                                                  fontWeight: FontWeight.w800,
                                                  color: AppColorManager
                                                      .textAppColor,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: AppHeightManager.h1,
                                            ),
                                            Wrap(
                                              children: List.generate(
                                                  rooms[index]['vnames']
                                                              .length >
                                                          2
                                                      ? 2
                                                      : rooms[index]['vnames']
                                                          .length, (i) {
                                                return MainAppButton(
                                                  margin: EdgeInsets.only(
                                                      right:
                                                          AppWidthManager.w2),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          AppWidthManager
                                                              .w3Point8,
                                                      vertical:
                                                          AppHeightManager.h02),
                                                  color: AppColorManager
                                                      .greyWithOpacity6,
                                                  child: AppTextWidget(
                                                    text: rooms[index]['vnames']
                                                            [i]['name'] +
                                                        ' view',
                                                    fontSize:
                                                        FontSizeManager.fs15,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColorManager
                                                        .textGrey,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
