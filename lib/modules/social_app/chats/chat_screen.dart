import 'package:FlutterApplications/layout/social_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/cubit/states.dart';
import 'package:FlutterApplications/models/social_app/social_user_model.dart';
import 'package:FlutterApplications/modules/social_app/chat_details/chat_details_screen.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).users.length > 0,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) =>
                buildChatItem(SocialCubit.get(context).users[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocialCubit.get(context).users.length,
          ),
        );
      },
    );
  }

  Widget buildChatItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ChatDetailsScreen(model));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                  '${model.image}',
                ),
              ),
              SizedBox(width: 15.0),
              Text('${model.name}'),
            ],
          ),
        ),
      );
}
