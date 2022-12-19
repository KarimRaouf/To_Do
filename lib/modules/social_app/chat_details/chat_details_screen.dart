import 'package:FlutterApplications/layout/social_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/cubit/states.dart';
import 'package:FlutterApplications/models/social_app/social_user_model.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/styles/colors.dart';
import 'package:FlutterApplications/shared/styles/icons_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatDetailsScreen extends StatelessWidget {
  SocialUserModel model;

  ChatDetailsScreen(this.model);

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: model.uId!);

      return BlocConsumer<SocialCubit, SocialState>(
        listener: (context, state) {
          print(SocialCubit.get(context).messages.length);
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(width: 15.0),
                  Text('${model.name}'),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).messages.length > 0,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var message =
                              SocialCubit.get(context).messages[index];
                          if (uId == message.senderId)
                            return buildMyMessage(message.text);
                          else
                            return buildMessage(message.text);
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 15),
                        itemCount: SocialCubit.get(context).messages.length,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: messageController,
                              decoration: InputDecoration(
                                hintText: 'type your message here...',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 10.0),
                              ),
                            ),
                          ),
                          Container(
                            height: 50.0,
                            color: defaultColor,
                            child: MaterialButton(
                              minWidth: 1.0,
                              onPressed: () {
                                SocialCubit.get(context).sendMessage(
                                  receiverId: model.uId!,
                                  dateTime: DateTime.now().toString(),
                                  text: messageController.text,
                                );
                              },
                              child: Icon(
                                IconBroken.Send,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(message) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          child: Text('${message}'),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
        ),
      );

  Widget buildMyMessage(message) => Align(
        alignment: AlignmentDirectional.topEnd,
        child: Container(
          child: Text('${message}'),
          padding: EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 5.0,
          ),
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10.0),
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
            ),
          ),
        ),
      );
}
