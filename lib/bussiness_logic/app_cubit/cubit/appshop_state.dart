part of 'appshop_cubit.dart';

@immutable
sealed class AppshopState {}

class AppshopInitial extends AppshopState {}

class Changenavstate extends AppshopState {}

class HomeshopLoading extends AppshopState{}
class HomeshopSuccess extends AppshopState{}
class HomeshopError extends AppshopState{}


class CategorieshopLoading extends AppshopState{}
class CategorieshopSuccess extends AppshopState{}
class CategorieshopError extends AppshopState{}

class ShopLoadingUserDataState extends AppshopState{}
class ShopSuccessUserDataState extends AppshopState{
  ShopLoginModel model;
  ShopSuccessUserDataState(this.model);
}
class ShopErrorUserDataState extends AppshopState{}
class Changefavourites extends AppshopState{}
class ChangefavouritesSuccess extends AppshopState{
   Changefavouritesmodel changefavouritesmodel;
   ChangefavouritesSuccess(this.changefavouritesmodel);
}


class ShopSuccessGetFavouritesState extends AppshopState{}
class ShopLoadingGetFavouritesState extends AppshopState{}
class ShopErrorGetFavouritesState extends AppshopState{}


class ChangefavouritesError extends AppshopState{}

class UpdateuserdataLoading extends AppshopState{}
class UpdateuserdataSuccess extends AppshopState{}
class UpdateuserdataError extends AppshopState{}
