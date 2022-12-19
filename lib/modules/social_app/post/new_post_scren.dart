import 'package:FlutterApplications/layout/social_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:FlutterApplications/shared/styles/icons_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/styles/colors.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Add Post',
            actions: [
              defaultTextButton(
                text: 'post',
                onPressed: () {
                  if (SocialCubit.get(context).postImage == null) {
                    SocialCubit.get(context).createPost(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  } else {
                    SocialCubit.get(context).uploadPostImage(
                      text: textController.text,
                      dateTime: DateTime.now().toString(),
                    );
                  }
                  if (state is! SocialCreatePostLoadingState)
                    Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg'),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      'Karim Abd El- Raouf',
                      style: TextStyle(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                if (SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                FileImage(SocialCubit.get(context).postImage!),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          SocialCubit.get(context).removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(width: 5.0),
                            Text('add photo'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text('# tags'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
