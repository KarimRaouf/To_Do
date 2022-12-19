import 'package:FlutterApplications/layout/social_app/social_layout.dart';
import 'package:FlutterApplications/modules/social_app/social_register/cubit/cubit.dart';
import 'package:FlutterApplications/modules/social_app/social_register/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/network/local/cache_helper.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (context, state) {
          if (state is SocialCreateUserSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(context, SocialLayout());
            });

            navigateAndFinish(
              context,
              SocialLayout(),
            );
          }
        },
        builder: (context, state) {
          var cubit = SocialRegisterCubit.get(context);
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
                          'REGISTER',
                          style:
                              Theme.of(context).textTheme.headline4!.copyWith(
                                    color: Colors.black,
                                  ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: Colors.grey,
                                  ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'User Name',
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty)
                                return 'please enter your name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15.0),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty) return 'email is too short';
                            }
                            return null;
                          },
                          onPress: () {},
                          onSubmit: (value) {},
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
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
                            if (formKey.currentState!.validate()) {}
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'phone',
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty)
                                return 'please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialRegisterLoadingState,
                          builder: (context) => defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                cubit.userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
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
