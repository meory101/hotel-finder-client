import 'package:flutter/material.dart';
import 'package:hotel_finder_client/core/storage/shared/shared_pref.dart';
import 'package:hotel_finder_client/feature/auth/screen/login_screen.dart';
import 'package:hotel_finder_client/feature/home/screen/room_details.dart';
import 'package:hotel_finder_client/feature/main/screen/main_bottom_app_bar_screen.dart';
import '../core/navigation/fade_builder_route.dart';
import '../core/widget/page/not_found_page.dart';
import '../feature/auth/screen/register_screen.dart';
import '../core/storage/shared/shared_pref.dart';
abstract class RouteNamedScreens {
  static  String init =AppSharedPreferences.getUserId().isEmpty?  register: bottomAppBar;
  static const String register = "/register";
  static const String login = "/login";
  static const String bottomAppBar = "/bottom-app-bar";
  static const String roomDetails = "/room-details";

}

abstract class AppRouter {
  static Route? onGenerateRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      case RouteNamedScreens.register:
        return FadeBuilderRoute(page: const RegisterScreen());
      case RouteNamedScreens.login:
        return FadeBuilderRoute(page: const LoginScreen());
      case RouteNamedScreens.bottomAppBar:
        return FadeBuilderRoute(page: const MainAppBottomAppBar());
      case RouteNamedScreens.roomDetails:
        argument as RoomDetailsArgs;
        return FadeBuilderRoute(page: RoomDetails(args: argument,));
    }
    return FadeBuilderRoute(page: const NotFoundScreen());
  }
}
