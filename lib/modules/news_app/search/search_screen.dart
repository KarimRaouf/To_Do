import 'package:FlutterApplications/layout/cubit/cubit.dart';
import 'package:FlutterApplications/layout/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  validate: (String? value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'search can not be empty';
                      }
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  onChange: (value) {
                    cubit.getSearch(value);
                  },
                ),
              ),
              Expanded(child: articleBuilder(cubit.search, context)),
            ],
          ),
        );
      },
    );
  }
}
