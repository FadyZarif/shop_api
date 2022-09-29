import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/network/end_point.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel ;

  void userLogin({required String email , required String password}){
    emit(LoginLoadingState());
      DioHelper.postData(
          url: LOGIN,
          data: {
            'email' : email,
            'password' : password
          }
      ).then((value) {
        loginModel = LoginModel.fromJason(value.data);
        emit(LoginSuccessState(loginModel!));
      }).catchError((error){
        print(error.toString());
        emit(LoginErrorState(error.toString()));
      });
  }

  bool isPassword = true;
  IconData suffixIcon = Icons.visibility;

  void changePasswordVisibility(){
    emit(LoginChangeVisibilityState());
    isPassword = !isPassword;
    if(isPassword) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
  }

}