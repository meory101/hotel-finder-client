import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hotel_finder_client/core/resource/color_manager.dart';
import 'package:hotel_finder_client/core/resource/size_manager.dart';
import 'package:hotel_finder_client/core/widget/button/main_app_button.dart';
import 'package:hotel_finder_client/core/widget/text/app_text_widget.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  final String? lat;
  final  String? long;
  const MapScreen({super.key, this.lat, this.long});
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  Position? cl;
  var lat;
  var long;
  CameraPosition? _kGooglePlex;
  late Set<Marker> mymarker;

  getLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.denied) {
      await Geolocator.requestPermission();
    }
    if (status == PermissionStatus.granted) {
      await getLatLong();
    }
  }

  getLatLong() async {
    cl = await Geolocator.getCurrentPosition().then((value) => (value));
    if (widget.lat != null) {
      lat = double.parse(widget.lat!);
      long = double.parse(widget.long!);
    } else {
      lat = cl?.latitude;
      long = cl?.longitude;
    }
    _kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 10.4746,
    );
    setState(() {
      mymarker = {
        Marker(markerId: MarkerId("1"), position: LatLng(lat, long)),
        Marker(
            onDragEnd: ((LatLng) => {print(LatLng)}),
            markerId: MarkerId("1"),
            position: LatLng(lat, long))
      };
    });
  }

  void initState() {
    getLocation();
    super.initState();
  }

  onDoneClicked() async {
    String latlong = '$lat*$long';
    Navigator.of(context).pop(latlong);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _kGooglePlex != null
            ? Stack(
                children: [
                  GoogleMap(
                    onTap: (LatLng) {
                      setState(() {
                        mymarker.add(
                            Marker(markerId: const MarkerId("1"), position: LatLng));
                        lat = LatLng.latitude;
                        long = LatLng.longitude;
                      });
                    },
                    markers: mymarker,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex!,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: MainAppButton(
                      alignment: Alignment.center,
                       onTap: () {
                         onDoneClicked();
                       },
                        width: AppWidthManager.w40,
                        height: AppHeightManager.h6,
                        color: AppColorManager.blackShadow,
                        child: const AppTextWidget(
                          text: 'Done',
                          color: AppColorManager.white,
                        )),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: AppColorManager.red,
                ),
              ),
      ),
    );
  }
}
