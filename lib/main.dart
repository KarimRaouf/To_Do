import 'package:FlutterApplications/layout/cubit/cubit.dart';
import 'package:FlutterApplications/layout/cubit/states.dart';
import 'package:FlutterApplications/layout/shop_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/social_layout.dart';
import 'package:FlutterApplications/modules/social_app/social_login/social_login_screen.dart';
import 'package:FlutterApplications/shared/bloc_observer.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:FlutterApplications/shared/styles/themes.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');

  Widget widget;
  if (uId != null)
    widget = SocialLayout();
  else
    widget = SocialLoginScreen();

  // if (onBoarding != null) {
  //   if (token != null)
  //     widget = ShopLayout();
  //   else
  //     widget = ShopLoginScreen();
  // } else
  //   widget = OnBoardingScreen();

  runApp(MyApp(
    isDark: isDark,
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  @override
  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark, this.startWidget});

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit(),
          // create: (context) => NewsCubit()..changeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => ShopCubit()
            ..getHomeData()
            ..getCategoriesData()
            ..getFavoriteData()
            ..getUserData(),
        ),
        BlocProvider(
          create: (context) => SocialCubit()
            ..getUserData()
            ..getPosts(),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: Directionality(
              textDirection: TextDirection.ltr,
              child: startWidget!,
            ),
          );
        },
      ),
    );
  }
}

//https://newsapi.org/v2/everything?q=s&apiKey=993d67f64ed243ff8231a8b916d7d73b
