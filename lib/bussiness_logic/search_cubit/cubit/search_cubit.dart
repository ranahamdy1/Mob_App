import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/constants/endpoints.dart';
import 'package:shop_app/data/dio/dio_helper.dart';
import 'package:shop_app/data/model/search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(SearchInitial searchInitial) : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;
  void getSearch(String text){
    DioHelper.postData(
    url: Endpoints.search,
    data: {
      'text':text
    }).then((value){
      searchModel =SearchModel.fromJson(value.data);
      emit(SearchSuccessStates(searchModel!));
    }).catchError((onError){
      emit(SearchErrorStates(onError));
      debugPrint(onError);
    });
  }

}
