import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';
import 'package:shop_app/presentation/screens/favorities/widgets.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit, AppshopState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavouritesState,
            builder: (context) => ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildProductItems(
                    AppshopCubit.get(context)
                        .favouritesModel!
                        .data!
                        .data[index]
                        .product,
                    context),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: AppshopCubit.get(context)
                    .favouritesModel!
                    .data!
                    .data
                    .length),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
