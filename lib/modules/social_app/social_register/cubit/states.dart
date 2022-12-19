abstract class SocialRegisterStates {}

class InitialRegisterState extends SocialRegisterStates {}

class SocialRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {}

class SocialCreateUserLoadingState extends SocialRegisterStates {}

class SocialCreateUserSuccessState extends SocialRegisterStates {
  final uId;
  SocialCreateUserSuccessState(this.uId);
}

class SocialCreateUserErrorState extends SocialRegisterStates {
  final error;

  SocialCreateUserErrorState(this.error);
}

class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates {
}
