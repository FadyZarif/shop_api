import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    if(value==true){
      token = '';
    }
  });
  navigateToReplacement(context, LoginScreen());
}

String token = '';