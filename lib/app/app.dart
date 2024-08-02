import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../router/router.dart';

final GlobalKey<NavigatorState> myAppKey = GlobalKey<NavigatorState>();

class HotelFinder extends StatefulWidget {
  const HotelFinder({super.key});

  @override
  State<HotelFinder> createState() => _HotelFinderState();
}

class _HotelFinderState extends State<HotelFinder> {


  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return
         MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouteNamedScreens.init,
      );
    });
  }
}
