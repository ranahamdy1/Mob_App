import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/search_cubit/cubit/search_cubit.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/presentation/screens/favorities/widgets.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchCubit, SearchState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormText(
                      control: searchController,
                      type: TextInputType.text,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Search Can\'t be Empty';
                        } else {
                          return null;
                        }
                      },
                      label: 'Search',
                      prefix: Icons.search,
                      onTap: () {},
                      onChanged: (value) {},
                      onSubmit: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context)
                              .getSearch(searchController.text);
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is SearchLoadingStates)
                    const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  if (state is SearchSuccessStates)
                    Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildProductItems(
                              SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data[index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel!
                              .data!
                              .data
                              .length),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
