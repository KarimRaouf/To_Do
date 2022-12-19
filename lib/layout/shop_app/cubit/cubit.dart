import 'package:FlutterApplications/layout/shop_app/cubit/states.dart';
import 'package:FlutterApplications/models/shop_app/categories_model.dart';
import 'package:FlutterApplications/models/shop_app/change_favorites_model.dart';
import 'package:FlutterApplications/models/shop_app/favorites_model.dart';
import 'package:FlutterApplications/models/shop_app/home_model.dart';
import 'package:FlutterApplications/models/shop_app/shop_login_model.dart';
import 'package:FlutterApplications/models/user/user_model.dart';
import 'package:FlutterApplications/modules/shop_app/categories/categories_screen.dart';
import 'package:FlutterApplications/modules/shop_app/favourites/favourites_screen.dart';
import 'package:FlutterApplications/modules/shop_app/products/products_screen.dart';
import 'package:FlutterApplications/modules/shop_app/settings_screen/settings_screen.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/network/end_points.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of<ShopCubit>(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      path: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      print(favorites);
      emit(ShopSuccessHomeDataState());
    }).catchError((onError) {
      emit(ShopErrorHomeDataState());
      print(onError);
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    DioHelper.getData(
      path: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      emit(ShopErrorHomeDataState());
      print(onError);
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());

    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavoriteData();
      }
      emit(ShopChangeFavoriteSuccessState());
    }).catchError((onError) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopChangeFavoriteErrorState());
    });
  }

  FavoriteModel? favoriteModel;

  void getFavoriteData() {
    emit(ShopLoadingFavoriteState());
    DioHelper.getData(
      path: FAVORITES,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);
      emit(ShopGetFavoriteSuccessState());
    }).catchError((onError) {
      emit(ShopChangeFavoriteErrorState());
      print(onError);
    });
  }

  ShopLoginModel? userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      path: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopGetUserDataSuccessState());
    }).catchError((onError) {
      emit(ShopGetUserDataErrorState());
      print(onError);
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateUserSuccessState());
    }).catchError((onError) {
      emit(ShopUpdateUserErrorState());
      print(onError);
    });
  }
}
