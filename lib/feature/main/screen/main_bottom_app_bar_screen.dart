import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_finder_client/feature/auth/screen/login_screen.dart';
import 'package:hotel_finder_client/feature/bookings/screen/booked_rooms_screen.dart';
import 'package:hotel_finder_client/feature/home/screen/home_screen.dart';
import 'package:hotel_finder_client/feature/profile/screen/profile_screen.dart';
import 'package:hotel_finder_client/feature/search/screen/search_screen.dart';

import '../../../core/resource/color_manager.dart';
import '../../../core/resource/icon_manager.dart';
import '../../../core/resource/size_manager.dart';
import '../../../core/widget/text/app_text_widget.dart';
int selectedIndex
 = 0;

class MainAppBottomAppBar extends StatefulWidget {
  final BottomAppBarArgs? args;

  const MainAppBottomAppBar({super.key, this.args});

  @override
  State<MainAppBottomAppBar> createState() => _MainAppBottomAppBarState();
}

class _MainAppBottomAppBarState extends State<MainAppBottomAppBar> {
  final List<Widget> bottomBarScreens = [
    const HomeScreen(),
    const SearchScreen(),
    const BookedRoomsScreen(),
    const ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: selectedIndex
 == 0,
      onPopInvoked: (didPop) {
        if (didPop == false) {
          setState(() {
            selectedIndex
 = 0;
          });
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
          backgroundColor: AppColorManager.background,
          bottomNavigationBar: BottomAppBar(
            height: AppHeightManager.h12,
            elevation: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColorManager.textAppColor,
                borderRadius: BorderRadius.circular(AppRadiusManager.r30),
              ),
              padding: EdgeInsets.only(
                top: AppWidthManager.w3Point8,
                bottom: AppWidthManager.w3Point8,
                left: AppWidthManager.w7,
                right: AppWidthManager.w7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    overlayColor: const MaterialStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      setState(() {
                        selectedIndex
 = 0;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(AppIconManager.home,
                            colorFilter: ColorFilter.mode(
                                selectedIndex
 == 0
                                    ? AppColorManager.white
                                    : AppColorManager.grey,
                                BlendMode.srcIn)),
                        AppTextWidget(
                          text: "home",
                          color: selectedIndex
 == 0
                              ? AppColorManager.white
                              : AppColorManager.grey,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    overlayColor: const MaterialStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      setState(() {
                        selectedIndex
 = 1;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(AppIconManager.search,
                            colorFilter: ColorFilter.mode(
                                selectedIndex
 == 1
                                    ? AppColorManager.white
                                    : AppColorManager.grey,
                                BlendMode.srcIn)),
                        AppTextWidget(
                          text: "Search",
                          color: selectedIndex
 == 1
                              ? AppColorManager.white
                              : AppColorManager.grey,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    overlayColor: const MaterialStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      setState(() {
                        selectedIndex
 = 2;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(AppIconManager.draft,
                            colorFilter: ColorFilter.mode(
                                selectedIndex
 == 2
                                    ? AppColorManager.white
                                    : AppColorManager.grey,
                                BlendMode.srcIn)),
                        AppTextWidget(
                          text: "Bookings",
                          color: selectedIndex
 == 2
                              ? AppColorManager.white
                              : AppColorManager.grey,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    overlayColor: const MaterialStatePropertyAll(
                        AppColorManager.transparent),
                    onTap: () {
                      setState(() {
                        selectedIndex
 = 3;
                      });
                    },
                    child: Column(
                      children: [
                        SvgPicture.asset(AppIconManager.user,
                            colorFilter: ColorFilter.mode(
                                selectedIndex
 == 3
                                    ? AppColorManager.white
                                    : AppColorManager.grey,
                                BlendMode.srcIn)),
                        AppTextWidget(
                          text: "profile",
                          color: selectedIndex
 == 3
                              ? AppColorManager.white
                              : AppColorManager.grey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(opacity: animation, child: child);
            },
            child: bottomBarScreens[selectedIndex
],
          )),
    );
  }
}

class BottomAppBarArgs {
  int? index;

  BottomAppBarArgs({this.index});
}
