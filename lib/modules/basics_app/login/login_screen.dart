import 'package:FlutterApplications/shared/components/components.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'email',
                    prefix: Icons.email,
                    validate: (value) {
                      if (value != null) {
                        if (value.isEmpty) return 'email can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  defaultFormField(
                    isPassword: isObsecure,
                    controller: passwordController,
                    type: TextInputType.visiblePassword,
                    label: 'password',
                    prefix: Icons.lock,
                    suffix:
                        isObsecure ? Icons.visibility : Icons.visibility_off,
                    onPress: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                    validate: (value) {
                      if (value != null) {
                        if (value.isEmpty) return 'password can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'login',
                    function: () {
                      bool? state = formKey.currentState?.validate();
                      if (state!) {
                        print(emailController.text);
                        print(passwordController.text);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'ReGisTER',
                    function: () {
                      print(emailController.text);
                      print(passwordController.text);
                    },
                    isUpperCase: false,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text('Register'),
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
  }
}
