import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/screens/auth/login_screen.dart';
import '../../../bussiness_logic/register/cubit/register_cubit.dart';
import '../../../constants/shard.dart';
import '../layout/layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                    backgroundColor: Colors.purple,
                    content: Text(
                      "wait",
                    ),
                  ));
        } else if (state is RegisterErrorState) {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    backgroundColor: Colors.purple,
                    content: Text(
                      state.error,
                    ),
                  ));
        } else if (state is RegisterSuccessState) {
          Navigator.pop(context);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LayoutScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 19,
                      ),
                      defaultFormText(
                          control: nameController,
                          onTap: () {},
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                          onSubmit: () {},
                          type: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'name Can not be Empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'name',
                          prefix: Icons.person),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormText(
                          control: emailController,
                          onTap: () {},
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                          onSubmit: () {},
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
                        height: 25,
                      ),
                      defaultFormText(
                          control: passwordController,
                          onTap: () {},
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                          onSubmit: () {},
                          type: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'password Can not be Empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'password',
                          prefix: Icons.password),
                      const SizedBox(
                        height: 25,
                      ),
                      defaultFormText(
                          control: numberController,
                          onTap: () {},
                          onChanged: (value) {
                            if (kDebugMode) {
                              print(value);
                            }
                          },
                          onSubmit: () {},
                          type: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'number Can not be Empty';
                            } else {
                              return null;
                            }
                          },
                          label: 'phone',
                          prefix: Icons.phone),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubit>(context)
                                  .userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                //password_confirmation:confirmpasswordController.text,
                                phone: numberController.text,
                              );
                              //Navigator.pushNamed(context, 'PatientSetTallScreen');
                            }
                          },
                          color: Colors.purple,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(70)),
                          child: const Text(
                            "sign up now",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                                navigateTo(context, ShopLoginScreen());
                              },
                              child: const Text('Login',
                                  style: TextStyle(color: Colors.purple)))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        );
      },
    );
  }
}
