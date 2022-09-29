import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{

  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);


  SearchModel? searchModel;

  void search({required String q}){
    emit(SearchLoadingState());
      DioHelper.postData(
          url: SEARCH_PRODUCT,
          data: {'text' : q}
      ).then((value) {
        searchModel = SearchModel.fromJson(value.data);
        emit(SearchSuccessState(searchModel));
      }).catchError((error){
        print(error.toString());
        emit(SearchErrorState());
      });
  }

  }