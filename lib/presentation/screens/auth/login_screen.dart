import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/login_cubit/cubit/login_cubit.dart';
import 'package:shop_app/bussiness_logic/login_cubit/cubit/login_state.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/presentation/screens/auth/regiser.dart';
import 'package:shop_app/presentation/screens/layout/layout.dart';
import 'package:shop_app/shardpref/cash_helper.dart';

class ShopLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailControl = TextEditingController();
  var passwordControl = TextEditingController();

  ShopLoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      listener: (context, state) {
        if (state is ShopLoginSuccessState) {
          if (state.loginModel.status == true) {
            if (kDebugMode) {
              print(state.loginModel.message);
            }
            if (kDebugMode) {
              print(state.loginModel.data!.token);
            }
            CashHelper.saveData(
                    key: 'token', value: state.loginModel.data!.token)
                .then((value) {
              token = state.loginModel.data!.token!;
              showToast(
                  text: (state.loginModel.message)!, state: ToastState.Success);
              navigateAndFinish(context, const LayoutScreen());
            });
          } else {
            showToast(
                text: (state.loginModel.message)!, state: ToastState.Error);
            if (kDebugMode) {
              print('${state.loginModel.message}this is login error');
            }
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Login',
                            style: TextStyle(fontFamily: "Cairo", fontSize: 25),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormText(
                              control: emailControl,
                              // onTap: () {},
                              // onChanged: (value) {
                              //   if (kDebugMode) {
                              //     print(value);
                              //   }
                              // },
                              // onSubmit: () {},
                              type: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Email Can not be Empty';
                                } else {
                                  return null;
                                }
                              },
                              label: 'Email',
                              prefix: Icons.email),
                          const SizedBox(
                            height: 15,
                          ),
                          defaultFormText(
                              control: passwordControl,
                              type: TextInputType.visiblePassword,
                              //onTap: () {},
                              // onChanged: (value) {
                              //   if (kDebugMode) {
                              //     print(value);
                              //   }
                              // },
                              // onSubmit: (value) {
                              //   if (formKey.currentState!.validate()) {
                              //     ShopLoginCubit.get(context).userLogin(
                              //         email: emailControl.text,
                              //         password: passwordControl.text);
                              //   }
                              // },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Password is to Short';
                                } else {
                                  return null;
                                }
                              },
                              isPassword:
                                  ShopLoginCubit.get(context).isPassword,
                              label: 'Password',
                              prefix: Icons.lock,
                              suffix: ShopLoginCubit.get(context).suffix,
                              suffixClicked: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  ShopLoginCubit.get(context).userLogin(
                                      email: emailControl.text,
                                      password: passwordControl.text);
                                }
                              },
                              child: Text("Login")),
                          // ConditionalBuilder(
                          //   condition: state is! ShopLoginLoadingState,
                          //   builder: (context) => defaultButton(
                          //     onTap: () {
                          //       if (formKey.currentState!.validate()) {
                          //         ShopLoginCubit.get(context).userLogin(
                          //             email: emailControl.text,
                          //             password: passwordControl.text);
                          //       }
                          //     },
                          //     text: 'Login',
                          //   ),
                          //   fallback: (context) => const Center(
                          //       child: CircularProgressIndicator()),
                          // ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't Have an Account?",
                                style: TextStyle(fontSize: 15),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, const SignUpScreen());
                                  },
                                  child: const Text('Register'))
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
