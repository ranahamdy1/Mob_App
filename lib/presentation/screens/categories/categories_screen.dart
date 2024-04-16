import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';
import 'package:shop_app/data/model/categories_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit,AppshopState>(
      listener: (context,state){},
      builder: (context,state)=>ListView.separated(
          physics: const BouncingScrollPhysics() ,
          itemBuilder: (context,index)=>catList(AppshopCubit.get(context).categoriesModel!.data.data[index]),
          separatorBuilder:(context,index)=> const Divider(),
          itemCount: AppshopCubit.get(context).categoriesModel!.data.data.length),
    );
  }
  Widget catList(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
       CachedNetworkImage(
        imageUrl: model.image,
        width: 100,
        height: 100,
        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => const Icon(Icons.error),
     ),
        const SizedBox(width: 20,),
        Text(
          model.name,
          style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20
          ),
        ),
        const Spacer(),
        IconButton(onPressed: (){},
            icon: const Icon(Icons.arrow_forward_ios))
      ],
    ),
  );
}
 