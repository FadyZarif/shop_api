class CategoriesModel{

  bool? status;
  CategoriesData? data;

  CategoriesModel.fromJsom(Map<String,dynamic> json){
    status = json['status'];
    data = CategoriesData.fromJsom(json['data']);
  }

}

class CategoriesData {

  int? currentPage;
  List<DataModel?> data=[];

  CategoriesData.fromJsom(Map<String,dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((e){
      data.add(DataModel.fromJsom(e));
    });
  }

}

class DataModel{
  int? id;
  String? name;
  String? image;


  DataModel.fromJsom(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}

