import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shardpref/cash_helper.dart';
import '../../../constants/endpoints.dart';
import '../../../data/dio/dio_helper.dart';
import '../../../data/model/register_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(initialState) : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel regiserModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    // String? password_confirmation,
    required String phone,
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: Endpoints.register, data:{
      "name":name,
      "email":email,
      "password":password,
      //"password_confirmation":password_confirmation,
      "phone": phone,

    }).then((value)async {
      regiserModel = RegisterModel.fromJson(value.data);
      await CashHelper.saveData(key: 'TOKEN', value: regiserModel.data?.token);
     // await CashHelper.removeData(key: 'TOKEN');
      print('${regiserModel.message}');
      emit(RegisterSuccessState(regiserModel));
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
      print(onError);
    });
  }
  //       .then((value) {
  //      print(value.data.runtimeType);
  //      print(value.data);
  //     regiserModel=RegisterModel.fromJson(value.data);
  //     print(value.data);
  //     if (kDebugMode) {
  //       print("=====");
  //     }
  //     if (kDebugMode) {
  //       print(value.data);
  //     }
  //     if (kDebugMode) {
  //       print("======");
  //     }
  //      emit(RegisterSuccessState(regiserModel));
  //   }).catchError((onError){
  //     if (kDebugMode) {
  //       print(onError.toString());
  //     }
  //     emit(RegisterErrorState(onError.toString()));
  //   });
  //
  // }

}


//  import 'dart:convert';
//
// import 'package:anime/constant/constant.dart';
// import 'package:anime/data/services/dio_helper.dart';
// import 'package:anime/data/models/register_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:meta/meta.dart';
//
// part 'register_state.dart';
//
// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit(initialState) : super(RegisterInitial());
//   static RegisterCubit get(context) => BlocProvider.of(context);
//
//   late RegisterModel regiserModel;
//
//   void userRegister({
//     required String name,
//     required String email,
//     required String password,
//     required String password_confirmation,
//     required String phone_number,
//   }){
//     emit(RegisterLoadingState());
//     DioHelper.postData(url: Endpoints.register, data: FormData.fromMap({
//       "name":name,
//       "email":email,
//       "password":password,
//       "password_confirmation":password_confirmation,
//       "phone_number": phone_number,
//
//     })).then((value) {
//       // print(value.data.runtimeType);
//       regiserModel=RegisterModel.fromJson(value.data);
//       if (kDebugMode) {
//         print("=====");
//       }
//       if (kDebugMode) {
//         print(value.data);
//       }
//       if (kDebugMode) {
//         print("======");
//       }
//        emit(RegisterSuccessState(regiserModel));
//     }).catchError((onError){
//       if (kDebugMode) {
//         print(onError.toString());
//       }
//       emit(RegisterErrorState(onError.toString()));
//     });
//
//   }
//
// }