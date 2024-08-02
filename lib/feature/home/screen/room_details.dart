import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/core/api/api_links.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/font_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/button/main_app_button.dart';
import '../../../core/widget/image/main_image_widget.dart';
import '../../../core/widget/text/app_text_widget.dart';

class RoomDetails extends StatefulWidget {
  final RoomDetailsArgs args;

  const RoomDetails({super.key, required this.args});

  @override
  State<RoomDetails> createState() => _RoomDetailsState();
}

class _RoomDetailsState extends State<RoomDetails> {
  @override
  void initState() {
    print(widget.args.roomData);
    print("ffffffffffffffffffff");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomSheet:  Container(
        color: AppColorManager.white,
        padding:  EdgeInsets.all(AppWidthManager.w3Point8),
        child: MainAppButton(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: AppWidthManager.w6, right: AppWidthManager.w3),
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
                    text:
                    'room price',
                    fontSize: FontSizeManager.fs13,
                    fontWeight: FontWeight.w600,
                    color: AppColorManager.greyWithOpacity6,
                  ),
                  AppTextWidget(
                    text:
                    '${widget.args.roomData['room']['price']}\$',
                    fontSize: FontSizeManager.fs16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(height: AppHeightManager.h05,)
                ],
              ),
              MainAppButton(
                alignment: Alignment.center,
                color: AppColorManager.white,
                width: AppWidthManager.w35,
                height: AppHeightManager.h6,
                borderRadius: BorderRadius.circular(AppRadiusManager.r50),
                child:  AppTextWidget(
                  text:
                  'Book Now',
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
            SizedBox(),
        Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppRadiusManager.r30),
              bottomRight: Radius.circular(
                AppRadiusManager.r30,
              ),
            ),),
          height: AppHeightManager.h50,
          child: MainImageWidget(
              fit: BoxFit.cover,
              imageUrl: '${imageUrl}'+'${widget.args.roomData['image'].first['image']}',
            ),
          ),
        
              Padding(
                padding:  EdgeInsets.all(AppWidthManager.w3Point8),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppTextWidget(
                              text: widget.args.roomData['room']
                              ['name'],
                              fontSize: FontSizeManager.fs18,
                              fontWeight: FontWeight.w700,
                              color: AppColorManager
                                  .textAppColor,
                            ),
                            SizedBox(
                              width: AppWidthManager.w1,
                            ),
                            AppTextWidget(
                              text:
                              '(${ widget.args.roomData['room']['capacity']} People)',
                              fontSize: FontSizeManager.fs15,
                              fontWeight: FontWeight.w600,
                              color: AppColorManager
                                  .textAppColor,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: AppHeightManager.h2,
                              width: AppHeightManager.h2,
                              child: SvgPicture.asset(
                                  AppIconManager.star),
                            ),
                            AppTextWidget(
                              text:
                              '${ widget.args.roomData['rate'] ?? ""} star',
                              fontSize: FontSizeManager.fs15,
                              fontWeight: FontWeight.w800,
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
                          text: widget.args.roomData['room']['price']
                              .toString(),
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
                      text:
                      'Room View',
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
                          margin: EdgeInsets.only(
                              right: AppWidthManager.w2),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              AppWidthManager.w3Point8,
                              vertical: AppHeightManager.h02),
                          color: AppColorManager
                              .greyWithOpacity6,
                          child: AppTextWidget(
                            text:widget.args.roomData['vnames'][i]
                            ['name'] +
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
                      text:
                      'Room Tools',
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
                          margin: EdgeInsets.only(
                              right: AppWidthManager.w2),
                          padding: EdgeInsets.symmetric(
                              horizontal:
                              AppWidthManager.w3Point8,
                              vertical: AppHeightManager.h02),
                          color: AppColorManager
                              .greyWithOpacity6,
                          child: AppTextWidget(
                            text:widget.args.roomData['tnames'][i]
                            ['name'] +
                                ' ',
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
                      height: AppHeightManager.h5,
                    )
                    ,


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
