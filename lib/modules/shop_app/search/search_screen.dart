import 'package:FlutterApplications/modules/shop_app/search/cubit/cubit.dart';
import 'package:FlutterApplications/modules/shop_app/search/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopSearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      label: 'search',
                      prefix: Icons.search,
                      validate: (String? value) {
                        if (value != null) {
                          if (value.isEmpty) {
                            return 'enter text to search';
                          }
                        }
                        return null;
                      },
                      onSubmit: (String value) {
                        cubit.search(text: value);
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (cubit.userModel != null && state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListItem(
                            cubit.userModel!.data!.data![index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: cubit.userModel!.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
