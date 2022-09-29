import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/register/cubit/cubit.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/network/local/cache_helper.dart';
import 'package:shop_app/shared/components/constants.dart';

import '../../shared/components/components.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            if(state.registerModel.status!){
              // print(state.loginModel.message);
              // print(state.loginModel.data?.token);
              defToast(
                msg: state.registerModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.green,
              );
              CacheHelper.saveData(key: 'token', value: state.registerModel.data?.token).then((value) {
                if(value==true){
                  token = '${state.registerModel.data?.token}';
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ShopLayout()));
                  //navigateToReplacement(context,  const ShopLayout());
                }
              });
            }
            else{
              // print(state.loginModel.message);
              defToast(
                msg: state.registerModel.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: Colors.red,
              );
            }
          }
          if(state is RegisterErrorState){
            defToast(
              msg: 'Connection Error',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
            );
          }
        },
        builder: (context,state){
          RegisterCubit cubit = RegisterCubit.get(context);
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
                        const Text("REGISTER",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange
                          ),),
                        const SizedBox(
                          height: 20,
                        ),
                        Text("register now to browse our offer",
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.deepOrange[300]
                          ),),
                        const SizedBox(
                          height: 40,
                        ),
                        defTextFormFiled(
                            textEditingController: nameController,
                            prefixIcon: const Icon(Icons.person),
                            labelText: 'Name',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter name';
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
                        defTextFormFiled(
                            textEditingController: phoneController,
                            prefixIcon: const Icon(Icons.phone),
                            labelText: 'Phone',
                            validator: (value){
                              if(value!.isEmpty){
                                return 'please enter your phone';
                              }
                              else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.phone
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context)=> defButton(
                            text: 'REGISTER',
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                cubit.newRegistration(
                                  name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text);
                              }
                            },
                            color: Colors.deepOrange,
                          ),
                          fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),

                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                               // navigateToReplacement(context,  LoginScreen());
                              },
                              child: const Text(
                                'Login Now',
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
