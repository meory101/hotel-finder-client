import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/api/api_links.dart';
import '../../../core/api/api_methods.dart';
import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';
import 'package:http/http.dart' as http;
class BookedRoomsScreen extends StatefulWidget {
  const BookedRoomsScreen({super.key});

  @override
  State<BookedRoomsScreen> createState() => _BookedRoomsScreenState();
}

class _BookedRoomsScreenState extends State<BookedRoomsScreen> {
int status = 0;
var reservations ;
  getReservations() async {
    setState(() {
      status = 0;
    });
    http.Response response =
    await HttpMethods().getMethod(ApiGetUrl.getUserReservations);

    if (response.statusCode == 200) {
      setState(() {
        status = 1;
      });

      reservations = jsonDecode(response.body);
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
  @override
  void initState() {
    // getReservations();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return

      RefreshIndicator(
        onRefresh: () {
          return getReservations();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: AppWidthManager.w2),
            child:
            reservations==null?
            Visibility
              (
              visible: true,
              child: SizedBox(
                height: AppHeightManager.h20,
                width: double.infinity,
                child: ListView.builder(
                  // padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: AppHeightManager.h30,
                              child: MainImageWidget(
                                height: AppHeightManager.h40,
                                borderRadius:
                                BorderRadius.circular(AppRadiusManager.r30),
                                fit: BoxFit.fill,
                                imageUrl: '',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: AppHeightManager.h2,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: AppHeightManager.h1point8,
                                  width: AppWidthManager.w40,
                                  decoration: BoxDecoration(
                                      color: AppColorManager.shimmerBaseColor,
                                      borderRadius: BorderRadius.circular(
                                          AppRadiusManager.r30)),
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
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
            )
                :

            Visibility(
              visible: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppHeightManager.h7,),
                  AppTextWidget(
                    text: "Your Reservations",
                    color: AppColorManager.black,
                    fontSize: FontSizeManager.fs17,
                    fontWeight: FontWeight.w700,
                    overflow: TextOverflow.visible,
                  ),            Padding(
                    padding:  EdgeInsets.symmetric(vertical: AppHeightManager.h3),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reservations.length,
                    itemBuilder: (context, index) {
                      return  Card(
                        surfaceTintColor: AppColorManager.transparent,
                        elevation: 4,
                        shadowColor: AppColorManager.greyWithOpacity1,
                        child: Container(
                            margin: EdgeInsets.only(

                                bottom: AppHeightManager.h1point8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                AppRadiusManager.r30,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.all(
                                        AppWidthManager.w3Point8),
                                    height: AppHeightManager.h15,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                          filterQuality: FilterQuality.high,
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '${imageUrl}${reservations[index]['image'].first['image']}',
                                          ),
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            AppRadiusManager.r20)),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
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
                                                  text: reservations[index]['room']
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
                                                  '(${reservations[index]['room']['capacity']} People)',
                                                  fontSize:
                                                  FontSizeManager.fs14,
                                                  fontWeight:
                                                  FontWeight.w600,
                                                  color: AppColorManager
                                                      .textAppColor,
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
                                              text: reservations[index]['room']
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
                                              text: reservations[index]['room']
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
                                        Row(
                                          children: [
                                            SizedBox(
                                              height:
                                              AppHeightManager.h2,
                                              width:
                                              AppHeightManager.h2,
                                              child: SvgPicture.asset(
                                                  AppIconManager.qua),
                                            ),
                                            AppTextWidget(
                                              text:
                                              '${reservations[index]['data']['date'].split(' ').first ??
                                                  ""} ',
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
                                  ),
                                )
                              ],
                            )),
                      );
                    },
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  }
}
