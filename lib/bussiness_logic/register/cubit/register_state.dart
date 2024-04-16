part of 'register_cubit.dart';


abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState{
  final RegisterModel regiserModel;
  RegisterSuccessState( this.regiserModel);
}
class RegisterErrorState extends RegisterState{
  final String error;
  RegisterErrorState(this.error);
}
