import 'package:hotel_finder_client/core/storage/shared/shared_pref.dart';

String _baseUrl = 'http://192.168.227.164:8000/api/';
String imageUrl = 'http://192.168.227.164:8000/storage/';

class ApiGetUrl {
  static  String getMostPopularRooms = '${_baseUrl}getMostPopularRooms';
  static  String getUserReservations = '${_baseUrl}getUserReservations/${AppSharedPreferences.getUserId()}';
  static  String getRooms = '${_baseUrl}getRooms';
  static  String getUserProfile = '${_baseUrl}getUserProfile/';

}

class ApiPostUrl {
static  String register = '${_baseUrl}userRegister';
static  String login = '${_baseUrl}userLogin';
static  String updateUserProfile = '${_baseUrl}updateUserProfile';
static  String reserveRoom = '${_baseUrl}reserveRoom';
  static  String getMostReleventRooms = '${_baseUrl}getMostReleventRooms';
}

class ApiDeleteUrl {}

class ApiPutUrl {}
