import 'package:FlutterApplications/layout/cubit/cubit.dart';
import 'package:FlutterApplications/layout/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  cubit.changeMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeBottomNavBarIndex(index);
            },
          ),
        );
      },
    );
  }
}
// base url : https://newsapi.org/
// // method (url) : v2/top-headlines?
// // queries : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca
