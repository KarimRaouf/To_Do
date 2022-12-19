import 'package:FlutterApplications/modules/shop_app/login/cubit/cubit.dart';

abstract class ShopRegisterStates {}

class InitialRegisterState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final loginModel;
  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
