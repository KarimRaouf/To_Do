import 'package:FlutterApplications/layout/shop_app/shop_layout.dart';
import 'package:FlutterApplications/models/shop_app/shop_login_model.dart';
import 'package:FlutterApplications/modules/shop_app/login/cubit/cubit.dart';
import 'package:FlutterApplications/modules/shop_app/login/cubit/states.dart';
import 'package:FlutterApplications/modules/shop_app/register/shop_register_screen.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:FlutterApplications/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.message);
              print(state.loginModel.data.token);
              CacheHelper.saveData(
                key: 'token',
                value: state.loginModel.data.token,
              ).then((value) {
                token = state.loginModel.data.token;
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              showToast(
                message: state.loginModel.message,
                backgroundColor: Colors.red,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          var cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Login now to browse out hot offers',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty)
                                return 'please enter your email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty) return 'password is too short';
                            }
                            return null;
                          },
                          suffix: cubit.suffix,
                          onPress: () {
                            cubit.changePasswordVisibility();
                          },
                          isPassword: cubit.isPasswordShown,
                          onSubmit: (value) {
                            if (formKey.currentState!.validate()) {
                              cubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                            text: 'login',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                              text: 'Register',
                              onPressed: () {
                                navigateTo(
                                  context,
                                  ShopRegisterScreen(),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
