import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/core/resource/color_manager.dart';
import 'package:hotel_finder_client/core/resource/font_manager.dart';
import 'package:hotel_finder_client/core/resource/icon_manager.dart';
import 'package:hotel_finder_client/core/resource/image_manager.dart';
import 'package:hotel_finder_client/core/resource/size_manager.dart';
import 'package:hotel_finder_client/core/storage/shared/shared_pref.dart';
import 'package:hotel_finder_client/core/widget/button/circular_text_button.dart';
import 'package:hotel_finder_client/core/widget/button/main_app_button.dart';
import 'package:hotel_finder_client/core/widget/image/main_image_widget.dart';
import 'package:hotel_finder_client/feature/home/screen/room_details.dart';
import 'package:hotel_finder_client/router/router.dart';
import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int status = 0;
  int statusRoom = 0;
  var popularRooms;
  var rooms;

  getPopularRooms() async {
    setState(() {
      status = 0;
    });
    http.Response response =
        await HttpMethods().getMethod(ApiGetUrl.getMostPopularRooms);

    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });

      popularRooms = jsonDecode(response.body);
    } else {
      setState(() {
        status = 2;
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

  getRooms() async {
    setState(() {
      statusRoom = 0;
    });
    http.Response response = await HttpMethods().getMethod(ApiGetUrl.getRooms);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        statusRoom = 1;
      });

      rooms = jsonDecode(response.body);
      print(rooms);
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

  onRoomClicked(roomData) {
    Navigator.of(context).pushNamed(
      RouteNamedScreens.roomDetails,
      arguments: RoomDetailsArgs(
        roomData: roomData,
      ),
    );
  }

  @override
  void initState() {
    getPopularRooms();
    getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColorManager.red,
      onRefresh: () {
        getPopularRooms();
        return getRooms();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                height: AppHeightManager.h30,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    image: AssetImage(
                      AppImageManager.main,
                    ),
                  ),
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadiusManager.r30),
                    bottomRight: Radius.circular(
                      AppRadiusManager.r30,
                    ),
                  ),
                ),
              ),
              Container(
                height: AppHeightManager.h30,
                width: AppWidthManager.w100,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  color: AppColorManager.mask,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(AppRadiusManager.r30),
                    bottomRight: Radius.circular(
                      AppRadiusManager.r30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppHeightManager.h5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: AppWidthManager.w5,
                          height: AppWidthManager.w5,
                          child: SvgPicture.asset(
                            AppIconManager.marker,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Norway",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSizeManager.fs15,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: AppHeightManager.h1,
                    ),
                    AppTextWidget(
                      text:
                          "Hey, ${AppSharedPreferences.getUserName()}! Tell us where you want to go today",
                      fontSize: FontSizeManager.fs20,
                      fontWeight: FontWeight.w700,
                      color: AppColorManager.white,
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: AppHeightManager.h1point8,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: AppWidthManager.w3Point8,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppRadiusManager.r50),
                          color: Colors.grey.withAlpha(100)),
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
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppHeightManager.h05,
              ),
              Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: AppTextWidget(
                  text: "The Most Popular",
                  fontWeight: FontWeight.w700,
                  fontSize: FontSizeManager.fs18,
                  color: AppColorManager.black,
                ),
              ),
              Visibility(
                visible: status == 0,
                child: SizedBox(
                  height: AppHeightManager.h45,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.only(left: 16),
                        height: AppHeightManager.h45,
                        width: AppWidthManager.w80,
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
                visible: status == 1 && popularRooms != null,
                child: SizedBox(
                  height: AppHeightManager.h45,
                  child: popularRooms == null
                      ? const SizedBox()
                      : ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: popularRooms.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                onRoomClicked(popularRooms[index]);
                              },
                              child: Card(
                                surfaceTintColor: AppColorManager.transparent,
                                elevation: 4,
                                shadowColor: AppColorManager.greyWithOpacity1,
                                child: Container(
                                    margin: EdgeInsets.only(
                                        left: AppWidthManager.w3Point8),
                                    height: AppHeightManager.h40,
                                    width: AppWidthManager.w80,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            AppRadiusManager.r30)),
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
                                                filterQuality:
                                                    FilterQuality.high,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  '$imageUrl${popularRooms[index]['image'].first['image']}',
                                                ),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                        text:
                                                            popularRooms[index]
                                                                    ['room']
                                                                ['name'],
                                                        fontSize:
                                                            FontSizeManager
                                                                .fs16,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColorManager
                                                            .textAppColor,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            AppWidthManager.w1,
                                                      ),
                                                      AppTextWidget(
                                                        text:
                                                            '(${popularRooms[index]['room']['capacity']} People)',
                                                        fontSize:
                                                            FontSizeManager
                                                                .fs14,
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
                                                            AppIconManager
                                                                .star),
                                                      ),
                                                      AppTextWidget(
                                                        text:
                                                            '${popularRooms[index]['rate'] ?? ""} star',
                                                        fontSize:
                                                            FontSizeManager
                                                                .fs15,
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
                                                    text: popularRooms[index]
                                                        ['room']['desc'],
                                                    fontSize:
                                                        FontSizeManager.fs15,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColorManager
                                                        .textGrey,
                                                    maxLines: 2,
                                                  ),
                                                  SizedBox(
                                                    width: AppWidthManager.w2,
                                                  ),
                                                  AppTextWidget(
                                                    text: popularRooms[index]
                                                            ['room']['price']
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
                                                    popularRooms[index]
                                                                    ['vnames']
                                                                .length >
                                                            2
                                                        ? 2
                                                        : popularRooms[index]
                                                                ['vnames']
                                                            .length, (i) {
                                                  return MainAppButton(
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            AppWidthManager.w2),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                AppWidthManager
                                                                    .w3Point8,
                                                            vertical:
                                                                AppHeightManager
                                                                    .h02),
                                                    color: AppColorManager
                                                        .greyWithOpacity6,
                                                    child: AppTextWidget(
                                                      text: popularRooms[index]
                                                                  ['vnames'][i]
                                                              ['name'] +
                                                          ' view',
                                                      fontSize:
                                                          FontSizeManager.fs15,
                                                      fontWeight:
                                                          FontWeight.w600,
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
              ),
              Padding(
                padding: EdgeInsets.all(AppWidthManager.w3Point8),
                child: AppTextWidget(
                  text: "Discover Rooms",
                  fontWeight: FontWeight.w700,
                  fontSize: FontSizeManager.fs18,
                  color: AppColorManager.black,
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
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: EdgeInsets.only(
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
          )
        ]),
      ),
    );
  }
}
