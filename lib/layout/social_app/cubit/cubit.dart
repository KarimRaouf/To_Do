import 'dart:io';

import 'package:FlutterApplications/layout/social_app/cubit/states.dart';
import 'package:FlutterApplications/models/social_app/message_model.dart';
import 'package:FlutterApplications/models/social_app/post_model.dart';
import 'package:FlutterApplications/models/social_app/social_user_model.dart';
import 'package:FlutterApplications/models/user/user_model.dart';
import 'package:FlutterApplications/modules/social_app/chats/chat_screen.dart';
import 'package:FlutterApplications/modules/social_app/feeds/feeds_screen.dart';
import 'package:FlutterApplications/modules/social_app/post/new_post_scren.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../modules/basics_app/users/uses_screen.dart';
import '../../../modules/social_app/settings/setting_screen.dart';
import '../../../modules/social_app/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of<SocialCubit>(context);

  SocialUserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data());
      userModel = SocialUserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen(),
  ];

  List<String> titles = ['Home', 'Chats', '', 'Users', 'Settings'];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNaveState());
    }
  }

  final picker = ImagePicker();
  File? profileImage;

  Future<void>? getProfileImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void>? getCoverImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: userModel!.email,
      phone: phone,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      bio: bio,
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId!)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error);
      emit(SocialUserUpdateErrorState());
    });
  }

  File? postImage;

  Future<void>? getPostImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
        print(value);
      }).catchError((error) {
        emit(SocialUploadPostImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadPostImageErrorState());
    });
  }

  void createPost({
    required String text,
    required String dateTime,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postId = [];
  List<int> likes = [];

  void getPosts() {
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
        emit(SocialGetPostsSuccessState());
      });
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }

  void likePosts(String uId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(uId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.id != uId)
            users.add(SocialUserModel.fromJson(element.data()));
        });
        print(users.length);
        emit(SocialGetAllUsersSuccessState());
      }).catchError((error) {
        print(error);
        emit(SocialGetAllUsersErrorState(error));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      receiverId: receiverId,
      dateTime: dateTime,
      text: text,
      senderId: uId,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId!)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(uId!)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      print(messages.length);
      emit(SocialGetMessageSuccessState());
    });
  }
}
