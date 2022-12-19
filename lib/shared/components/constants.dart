import 'package:FlutterApplications/modules/shop_app/login/shop_login_screen.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';

void signOut(context) {
  CacheHelper.removeData(key: 'token').then(
    (value) {
      navigateAndFinish(context, ShopLoginScreen());
    },
  );
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;
String? uId;
