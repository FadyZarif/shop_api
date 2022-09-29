import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/styles/themes.dart';

import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding')??false;
  token = CacheHelper.getData(key: 'token')??'';
  print(token);
  //CacheHelper.clearData();
  runApp( MyApp(onBoarding:onBoarding,token: token,));
}

class MyApp extends StatelessWidget {
  final bool? onBoarding;
  final String? token;
   MyApp( {super.key, this.onBoarding, this.token,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context)=>ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        home: !onBoarding!? const OnBoardingScreen() : token == ''?  LoginScreen(): const ShopLayout()
      ),
    );
  }
}
