abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavBarState extends ShopStates {}


class ShopLoadingHomeState extends ShopStates {}

class ShopSuccessHomeState extends ShopStates {}

class ShopErrorHomeState extends ShopStates {
  final String error;

  ShopErrorHomeState(this.error);
}

class ShopLoadingCategoriesState extends ShopStates {}


class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {
  final String error;
  ShopErrorCategoriesState(this.error);
}

class ShopLoadingFavoritesState extends ShopStates {}


class ShopSuccessFavoritesState extends ShopStates {}

class ShopErrorFavoritesState extends ShopStates {
  final String error;
  ShopErrorFavoritesState(this.error);
}


class ShopLoadingUserDataState extends ShopStates {}


class ShopSuccessUserDataState extends ShopStates {}

class ShopErrorUserDataState extends ShopStates {
  final String error;
  ShopErrorUserDataState(this.error);
}

class ShopLoadingUpdateUserDataState extends ShopStates {}


class ShopSuccessUpdateUserDataState extends ShopStates {}

class ShopErrorUpdateUserDataState extends ShopStates {
  final String error;
  ShopErrorUpdateUserDataState(this.error);
}



class ShopChangeFavoritesState extends ShopStates {}


class ShopSuccessChangeFavoritesState extends ShopStates {
  final changeFavoritesModel;

  ShopSuccessChangeFavoritesState(this.changeFavoritesModel);

}

class ShopErrorChangeFavoritesState extends ShopStates {
  final changeFavoritesModel;

  ShopErrorChangeFavoritesState(this.changeFavoritesModel);
}

class ShopChangeEditingState extends ShopStates{}




