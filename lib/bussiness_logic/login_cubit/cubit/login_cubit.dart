import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/login_cubit/cubit/login_state.dart';
import 'package:shop_app/constants/endpoints.dart';
import 'package:shop_app/data/dio/dio_helper.dart';
import 'package:shop_app/data/model/login_model.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit(initialState) : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;

  void userLogin({required String email, required String password}) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(lang: 'en', token: '', url: Endpoints.login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.formJson(value.data);
      print(loginModel.status);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = false;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(ShopLoginPasswordVisibility());
  }
}
