import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/data/model/categories_model.dart';
import 'package:shop_app/data/model/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppshopCubit, AppshopState>(
      listener: (context, state) {
        if (state is ChangefavouritesSuccess) {
          if (state.changefavouritesmodel.status!) {
            showToast(
                text: state.changefavouritesmodel.message!,
                state: ToastState.Error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ConditionalBuilder(
              // ignore: unnecessary_null_comparison
              condition: AppshopCubit.get(context).homeModel != null &&
                  AppshopCubit.get(context).categoriesModel != null,
              builder: (context) => productBuilder(
                  AppshopCubit.get(context).homeModel!,
                  AppshopCubit.get(context).categoriesModel!,
                  context),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget categoriesList(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          CachedNetworkImage(
            imageUrl: model.image,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              model.name,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          )
        ],
      );

  Widget productBuilder(
          HomeModel homeModel, CategoriesModel categoriesModel, context) =>
      SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CarouselSlider(
              items: homeModel.data.banners
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: "${e.image}",
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                autoPlayAnimationDuration: (const Duration(seconds: 2)),
                reverse: false,
                initialPage: 0,
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                autoPlayInterval: const Duration(seconds: 5),
                viewportFraction: 1,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          categoriesList(categoriesModel.data.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                      itemCount: categoriesModel.data.data.length),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'New Product',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 1,
                ),
                Container(
                  color: const Color.fromARGB(255, 255, 250, 250),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    childAspectRatio: 1 / 1.9,
                    children: List.generate(
                        homeModel.data.products.length,
                        (index) => buildGridproducts(
                            homeModel.data.products[index], context)),
                  ),
                )
              ],
            )
          ]));

  Widget buildGridproducts(ProductModel model, context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            CachedNetworkImage(
              width: 200,
              height: 200,
              fit: BoxFit.fill,
              imageUrl: "${model.image}",
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            if (model.discount != 0)
              Container(
                color: Colors.red,
                child: const Text("Discount"),
              )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "${model.name}",
              style: const TextStyle(
                  height: 2,
                  fontFamily: "Cairo",
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${model.price}",
                  style: const TextStyle(height: 2, color: Colors.blueAccent),
                ),
                const SizedBox(
                  width: 20,
                ),
                if (model.discount != 0)
                  Text(
                    "${model.oldPrice}",
                    style: const TextStyle(
                        height: 2, decoration: TextDecoration.lineThrough),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      AppshopCubit.get(context).changeFavourities(model.id);
                      if (kDebugMode) {
                        print(model.id);
                      }
                    },
                    icon: CircleAvatar(
                        backgroundColor:
                            AppshopCubit.get(context).favourites[model.id]!
                                ? Colors.red
                                : Colors.grey,
                        radius: 15,
                        child: const Icon(Icons.favorite_outline)))
              ],
            ),
          ],
        )
      ],
    );
  }
}
