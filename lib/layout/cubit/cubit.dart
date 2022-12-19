import 'package:FlutterApplications/layout/cubit/states.dart';
import 'package:FlutterApplications/modules/news_app/business/business_screen.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../modules/news_app/science/science_screen.dart';
import '../../modules/news_app/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of<NewsCubit>(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBarIndex(int index) {
    currentIndex = index;
    if (currentIndex == 1)
      getSports();
    else
      getScience();
    emit(NewsBottomNavStates());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getData(
      path: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '993d67f64ed243ff8231a8b916d7d73b',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business);

      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());

    if (sports.length == 0) {
      DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '993d67f64ed243ff8231a8b916d7d73b',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        path: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '993d67f64ed243ff8231a8b916d7d73b',
        },
      ).then((value) {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science);

        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsToggleModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsToggleModeState());
      });
    }
  }

  void getSearch(String value) {
    emit(NewsSearchLoadingState());
    DioHelper.getData(
      path: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '993d67f64ed243ff8231a8b916d7d73b',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search);

      emit(NewsSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsSearchErrorState(error.toString()));
    });
  }
}
