import 'package:FlutterApplications/models/shop_app/shop_login_model.dart';
import 'package:FlutterApplications/modules/shop_app/login/cubit/states.dart';
import 'package:FlutterApplications/shared/network/end_points.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(InitialLoginState());

  static ShopLoginCubit get(context) =>
      BlocProvider.of<ShopLoginCubit>(context);

  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}
