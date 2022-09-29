import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

import 'cubit/states.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({Key? key}) : super(key: key);
  
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            if(state.loginModel.status!){
              // print(state.loginModel.message);
              // print(state.loginModel.data?.token);
              defToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
              );
              CacheHelper.saveData(key: 'token', value: state.loginModel.data?.token).then((value) {
                if(value==true){
                  token = '${state.loginModel.data?.token}';
                  navigateToReplacement(context, const ShopLayout());
                }
              });
            }
            else{
              // print(state.loginModel.message);
              defToast(
                msg: state.loginModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );
            }
          }
          if(state is LoginErrorState){
            defToast(
              msg: 'Connection Error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );
            print(state.error.toString());
          }
        },
        builder: (context,state){
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("LOGIN",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange
                          ),),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("Login now to browse our offer",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.deepOrange[300]
                          ),),
                        const SizedBox(
                          height: 40,
                        ),
                        defTextFormFiled(
                            textEditingController: emailController,
                            prefixIcon: const Icon(Icons.email_outlined),
                            labelText: 'Email',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter email';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        defTextFormFiled(
                            textEditingController: passwordController,
                            prefixIcon: const Icon(Icons.lock_outline),
                            labelText: 'Password',
                            password: cubit.isPassword,
                            suffixIcon:  IconButton(
                              onPressed: (){
                                cubit.changePasswordVisibility();
                              },
                                icon: Icon(cubit.suffixIcon),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context)=> defButton(
                            text: 'LOGIN',
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                cubit.userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            color: Colors.deepOrange,
                          ),
                          fallback: (BuildContext context) => Center(child: const CircularProgressIndicator()),

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                navigateToReplacement(context,  RegisterScreen());
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        )

                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
