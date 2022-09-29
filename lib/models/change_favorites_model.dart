class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesDataModel? data;

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
    status = json['status'];
    message = json['message'];
    data = data == null? null :  ChangeFavoritesDataModel.fromJson(json['data']);

  }

}

class ChangeFavoritesDataModel{

  int? id;
  ChangeFavoritesProductDataModel? product;


  ChangeFavoritesDataModel.fromJson(Map<String,dynamic> json){
    id= json['id'];
    product = ChangeFavoritesProductDataModel.fromJson(json['product']);
  }

}

class ChangeFavoritesProductDataModel{

  int? productId;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;

  ChangeFavoritesProductDataModel.fromJson(Map<String,dynamic> json){
    productId = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}