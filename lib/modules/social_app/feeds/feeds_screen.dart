import 'package:FlutterApplications/layout/social_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/social_app/cubit/states.dart';
import 'package:FlutterApplications/models/user/user_model.dart';
import 'package:FlutterApplications/shared/styles/colors.dart';
import 'package:FlutterApplications/shared/styles/icons_broken.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/social_app/post_model.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {
        print(SocialCubit.get(context).posts.length);
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocialCubit.get(context).posts.length > 0 &&
              SocialCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      margin: EdgeInsets.all(8.0),
                      child: Image(
                        image: NetworkImage(
                            'https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                        fit: BoxFit.cover,
                        height: 200.0,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildPostItem(
                      SocialCubit.get(context).posts[index], context, index),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 8.0,
                  ),
                  itemCount: SocialCubit.get(context).posts.length,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context, index) => Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage: NetworkImage('${model.image}'),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(
                                height: 1.4,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.check_circle,
                              color: defaultColor,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          '${model.dateTime}',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(height: 1.4),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.more_horiz,
                      size: 16.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                  width: double.infinity,
                ),
              ),
              Text(
                '${model.text}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5.0),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#software',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: defaultColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 5.0),
                        child: Container(
                          height: 25.0,
                          child: MaterialButton(
                            minWidth: 1.0,
                            padding: EdgeInsets.zero,
                            onPressed: () {},
                            child: Text(
                              '#flutter',
                              style:
                                  Theme.of(context).textTheme.caption!.copyWith(
                                        color: defaultColor,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: 140.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            children: [
                              Icon(
                                IconBroken.Heart,
                                size: 16.0,
                                color: Colors.red,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '${SocialCubit.get(context).likes[index]}',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                IconBroken.Chat,
                                size: 16.0,
                                color: Colors.amber,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                '500 comment',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  height: 1.0,
                  color: Colors.grey[300],
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15.0,
                          backgroundImage: NetworkImage(
                            '${model.image}',
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Text(
                          'write a comment',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                  Spacer(),
                  InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 16.0,
                            color: Colors.red,
                          ),
                          SizedBox(width: 5.0),
                          Text(
                            'Like',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      SocialCubit.get(context)
                          .likePosts(SocialCubit.get(context).postId[index]);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
