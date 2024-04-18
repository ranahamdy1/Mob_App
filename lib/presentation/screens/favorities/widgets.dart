import 'package:flutter/material.dart';
import 'package:shop_app/bussiness_logic/app_cubit/cubit/appshop_cubit.dart';

Widget buildProductItems(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage((model.image)!),
                  width: 120,
                  height: 120,
                ),
                if ((model.discount) != 0 && isOldPrice)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
              ],
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (model.name)!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        (model.price.toString()),
                        style: const TextStyle(
                            fontSize: 12, color: Colors.blueAccent),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if ((model.discount) != 0 && isOldPrice)
                        Text(
                          model.discount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          AppshopCubit.get(context)
                              .changeFavourities((model.id)!);
                          // print(model.id);
                        },
                        icon: CircleAvatar(
                            backgroundColor:
                                AppshopCubit.get(context).favourites[model.id]!
                                    ? Colors.red
                                    : Colors.grey,
                            radius: 15,
                            child: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 14,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
