import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/change_favorites_model.dart';
import 'package:shop_app/models/favoirtes_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screensList = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];

  List<BottomNavigationBarItem> bottomNavBarItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: 'CATEGORIES'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'FAVORITE'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'SETTINGS'),
  ];

  void changeNavBar(int i) {
    currentIndex = i;
    emit(ShopChangeBottomNavBarState());
  }

  HomeModel? homeModel;

  Map<int, bool> favoirtes = {};

  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favoirtes.addAll({element.id!: element.inFavorites!});
      });
      emit(ShopSuccessHomeState());
    }).catchError((error) {
      emit(ShopErrorHomeState(error.toString()));
    });
  }

  CategoriesModel? categoriesModel;

  void getCategoriesData() {
    emit(ShopLoadingCategoriesState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJsom(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      emit(ShopErrorCategoriesState(error.toString()));
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData() {
    emit(ShopLoadingFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorFavoritesState(error.toString()));
    });
  }

  LoginModel? loginModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
        url: PROFILE,
        token: token
    ).then((value) {
      loginModel = LoginModel.fromJason(value.data);
      emit(ShopSuccessUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState(error.toString()));
    });
  }

  bool isEditing = false;
  void startEditing(){
    isEditing = !isEditing;
    emit(ShopChangeEditingState());
  }

  void updateUserData({required String name, required String email, required String phone}) {
    emit(ShopLoadingUpdateUserDataState());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },

    ).then((value) {

      loginModel = LoginModel.fromJason(value.data);
      isEditing = !isEditing;
      emit(ShopSuccessUpdateUserDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserDataState(error.toString()));
    });
  }



  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites({ required int productId}){
    favoirtes[productId] = !favoirtes[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {'product_id':productId},
      token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status!){
        favoirtes[productId] = !favoirtes[productId]!;
        emit(ShopErrorChangeFavoritesState(changeFavoritesModel));
      }
      else{
        getFavoritesData();
        emit(ShopSuccessChangeFavoritesState(changeFavoritesModel));
      }


    }).catchError((error){
      favoirtes[productId] = !favoirtes[productId]!;
      print(error.toString());
          emit(ShopErrorChangeFavoritesState(error));
    });
  }



}
