abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialState {}

class SocialGetAllUsersSuccessState extends SocialState {}

class SocialGetAllUsersErrorState extends SocialState {
  final error;

  SocialGetAllUsersErrorState(this.error);
}

class SocialChangeBottomNaveState extends SocialState {}

class SocialNewPostState extends SocialState {}

class SocialProfileImagePickedSuccessState extends SocialState {}

class SocialProfileImagePickedErrorState extends SocialState {}

class SocialCoverImagePickedSuccessState extends SocialState {}

class SocialCoverImagePickedErrorState extends SocialState {}

class SocialUploadProfileImageSuccessState extends SocialState {}

class SocialUploadProfileImageErrorState extends SocialState {}

class SocialUploadCoverImageSuccessState extends SocialState {}

class SocialUploadCoverImageErrorState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}

class SocialUserUpdateLoadingState extends SocialState {}

// Post
class SocialCreatePostLoadingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialPostImagePickedSuccessState extends SocialState {}

class SocialPostImagePickedErrorState extends SocialState {}

class SocialUploadPostImageSuccessState extends SocialState {}

class SocialUploadPostImageErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialGetPostsLoadingState extends SocialState {}

class SocialGetPostsSuccessState extends SocialState {}

class SocialGetPostsErrorState extends SocialState {
  final error;

  SocialGetPostsErrorState(this.error);
}

class SocialLikePostsSuccessState extends SocialState {}

class SocialLikePostsErrorState extends SocialState {
  final error;

  SocialLikePostsErrorState(this.error);
}

// Chat
class SocialGetMessageSuccessState extends SocialState {}

class SocialGetMessageErrorState extends SocialState {
  final error;

  SocialGetMessageErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {
  final error;

  SocialSendMessageErrorState(this.error);
}
