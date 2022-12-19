import 'package:FlutterApplications/models/shop_app/search_model.dart';
import 'package:FlutterApplications/modules/shop_app/search/cubit/states.dart';
import 'package:FlutterApplications/shared/components/constants.dart';
import 'package:FlutterApplications/shared/network/end_points.dart';
import 'package:FlutterApplications/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(SearchInitialState());

  static get(context) => BlocProvider.of<ShopSearchCubit>(context);

  SearchModel? model;

  void search({
    required String text,
  }) {
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error) {
      emit(SearchErrorState());
    });
  }
}
