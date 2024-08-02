abstract class AppLottieManager {
  static const String _lottieBasePath = 'assets/lottie';
  static String splash({String? splashId}) =>
      '$_lottieBasePath/splash${splashId != null ? "_$splashId" : ""}.json';
}
