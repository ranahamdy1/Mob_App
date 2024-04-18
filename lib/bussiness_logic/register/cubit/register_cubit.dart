import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/shared_pref/cash_helper.dart';
import '../../../constants/endpoints.dart';
import '../../../data/dio/dio_helper.dart';
import '../../../data/model/register_model.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(initialState) : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late RegisterModel registerModel;

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    DioHelper.postData(url: Endpoints.register, data: {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    }).then((value) async {
      registerModel = RegisterModel.fromJson(value.data);
      await CashHelper.saveData(key: 'TOKEN', value: registerModel.data?.token);
      print('${registerModel.message}');
      emit(RegisterSuccessState(registerModel));
    }).catchError((onError) {
      emit(RegisterErrorState(onError.toString()));
      print(onError);
    });
  }
}

