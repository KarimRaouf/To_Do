import 'package:FlutterApplications/layout/shop_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/shop_app/cubit/states.dart';
import 'package:FlutterApplications/modules/shop_app/login/shop_login_screen.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (cubit.userModel != null) {
          nameController.text = cubit.userModel!.data!.name!;
          emailController.text = cubit.userModel!.data!.email!;
          phoneController.text = cubit.userModel!.data!.phone!;
          return ConditionalBuilder(
            condition: state is! ShopLoadingUserDataState,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (state is ShopLoadingUpdateUserState)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'name must not be empty';
                              }
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'email address is too short';
                              }
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (String? value) {
                            if (value != null) {
                              if (value.isEmpty) {
                                return 'phone must not be empty';
                              }
                            }
                            return null;
                          }),
                      SizedBox(
                        height: 20.0,
                      ),
                      defaultButton(
                        function: () {
                          if (formKey.currentState!.validate()) {
                            cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                          }
                        },
                        text: 'update',
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
