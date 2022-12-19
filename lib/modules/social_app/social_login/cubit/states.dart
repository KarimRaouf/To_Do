abstract class SocialLoginStates {}

class InitialLoginState extends SocialLoginStates {}

class SocialLoginLoadingState extends SocialLoginStates {}

class SocialLoginSuccessState extends SocialLoginStates {
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginStates {
  final error;

  SocialLoginErrorState(this.error);
}

class SocialChangePasswordVisibilityState extends SocialLoginStates {}
