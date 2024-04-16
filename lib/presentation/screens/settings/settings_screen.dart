import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';
import 'package:shop_app/constants/shard.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {
        if (state is ShopSuccessUserDataState) {
          showToast(
              text: 'User Information Updated Successfully ',
              state: ToastState.Success);
        }
        if (state is ShopErrorUserDataState) {
          showToast(
              text: 'User Information don\'t Updated',
              state: ToastState.Success);
        }
      },
      builder: (context, state) {
        var model = AppshopCubit.get(context).userData;
        if (model != null) {
          nameController.text = model.data!.name!;
          phoneController.text = model.data!.phone!;
          emailController.text = model.data!.email!;
          if (kDebugMode) {
            print('${nameController.text} new one 2');
          }
        }
        return ConditionalBuilder(
          condition: AppshopCubit.get(context).userData != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (state is ShopLoadingUserDataState)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormText(
                      onTap: () {},
                      onChanged: (value) {
                        if (kDebugMode) {
                          print(value);
                        }
                      },
                      onSubmit: () {},
                      control: nameController,
                      type: TextInputType.name,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Name Cant be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormText(
                      onTap: () {},
                      onChanged: () {},
                      control: emailController,
                      type: TextInputType.emailAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'emailAddress Cant be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Email',
                      prefix: Icons.email),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultFormText(
                      onTap: () {},
                      onChanged: () {},
                      control: phoneController,
                      type: TextInputType.phone,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'phone Cant be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'phone',
                      prefix: Icons.phone),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          AppshopCubit.get(context).updateUserdata(
                            name: nameController.text,
                            phone: phoneController.text,
                            email: emailController.text,
                          );
                          if (kDebugMode) {
                            print('${nameController.text} new one');
                          }
                        }
                      },
                      text: 'Update'),
                  const SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      onTap: () {
                        signOut(context);
                      },
                      text: 'Logout'),
                ],
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
