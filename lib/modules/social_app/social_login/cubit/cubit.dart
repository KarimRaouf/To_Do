import 'package:FlutterApplications/modules/social_app/social_login/cubit/states.dart';
import 'package:FlutterApplications/shared/network/end_points.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(InitialLoginState());

  static SocialLoginCubit get(context) =>
      BlocProvider.of<SocialLoginCubit>(context);

  void userLogin({required String email, required String password}) {
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
      print(error);
    });
  }

  IconData suffix = Icons.visibility_outlined;

  bool isPasswordShown = true;

  void changePasswordVisibility() {
    isPasswordShown = !isPasswordShown;
    suffix = isPasswordShown
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
  }
}
