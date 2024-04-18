import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants/endpoints.dart';
import 'package:shop_app/constants/shard.dart';
import 'package:shop_app/data/dio/dio_helper.dart';
import 'package:shop_app/data/model/categories_model.dart';
import 'package:shop_app/data/model/change_favourites_model.dart';
import 'package:shop_app/data/model/favourites.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/login_model.dart';
import 'package:shop_app/presentation/screens/categories/categories_screen.dart';
import 'package:shop_app/presentation/screens/favorities/fav_screen.dart';
import 'package:shop_app/presentation/screens/home/home_screen.dart';
import 'package:shop_app/presentation/screens/settings/settings_screen.dart';

part 'appshop_state.dart';

class AppshopCubit extends Cubit<AppshopState> {
  AppshopCubit(AppshopInitial appshopInitial) : super(AppshopInitial());
  static AppshopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreens = const [
    HomeScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];

  void changeNavbar(int index) {
    currentIndex = index;
    emit(Changenavstate());
  }

  HomeModel? homeModel;
  Map<int, bool> favourites = {};

  void getHomedata() {
    DioHelper.getData(url: Endpoints.home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      for (var element in homeModel!.data.products) {
        favourites.addAll({element.id: element.favorites});
      }

      if (kDebugMode) {
        print(homeModel!.data.banners[0].image);
      }
      if (kDebugMode) {
        print(homeModel!.status.toString());
      }
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(HomeshopError());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesdata() {
    emit(CategorieshopLoading());
    DioHelper.getData(url: Endpoints.categories).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(CategorieshopSuccess());
    }).catchError((onError) {
      if (kDebugMode) {
        print(onError.toString());
      }
      emit(CategorieshopError());
    });
  }

  ShopLoginModel? userData;
  void getUserData() {
    DioHelper.getData(url: Endpoints.profile, token: token).then((value) {
      emit(ShopLoadingUserDataState());
      userData = ShopLoginModel.formJson(value.data);
      printFullText((userData!.data!.name)!);
      emit(ShopSuccessUserDataState(userData!));
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(ShopErrorUserDataState());
    });
  }

  //fav
  Changefavouritesmodel? changefavouritesmodel;
  void changeFavourities(int productId) {
    emit(Changefavourites());
    favourites[productId] = !favourites[productId]!;

    DioHelper.postData(
            url: Endpoints.favorites,
            data: {'product_id': productId},
            token: token)
        .then((value) {
      changefavouritesmodel = Changefavouritesmodel.fromjson(value.data);
      if (!changefavouritesmodel!.status!) {
        favourites[productId] = !favourites[productId]!;
      } else {
        getFavourites();
      }
      emit(ChangefavouritesSuccess(changefavouritesmodel!));
    }).catchError((onError) {
      favourites[productId] = !favourites[productId]!;
      emit(ChangefavouritesError());
      debugPrint(onError);
    });
  }

  FavouritesModel? favouritesModel;
  void getFavourites() {
    DioHelper.getData(url: Endpoints.favorites, token: token).then((value) {
      favouritesModel = FavouritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavouritesState());
    }).catchError((onError) {
      emit(ShopErrorGetFavouritesState());
      debugPrint(onError);
    });
  }

  void updateUserdata({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(UpdateuserdataLoading());
    DioHelper.putData(
        url: Endpoints.updateprofile,
        token: token,
        data: {'name': name, 'phone': phone, 'email': email}).then((value) {
      userData = ShopLoginModel.formJson(value.data);
      emit(UpdateuserdataSuccess());
      if (kDebugMode) {
        print("update is Ok");
      }
    });
  }
}
