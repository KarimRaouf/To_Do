import 'package:FlutterApplications/layout/shop_app/cubit/cubit.dart';
import 'package:FlutterApplications/layout/shop_app/cubit/states.dart';
import 'package:FlutterApplications/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        if (cubit.favoriteModel != null) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingFavoriteState,
            builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildListItem(
                cubit.favoriteModel!.data!.data![index].product,
                context,
              ),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: cubit.favoriteModel!.data!.data!.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
