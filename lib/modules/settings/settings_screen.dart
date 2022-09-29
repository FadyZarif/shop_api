import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);



          return ConditionalBuilder(
            condition: cubit.loginModel != null,
            builder: (context) {
              nameController.text = cubit.loginModel!.data!.name!;
              emailController.text = cubit.loginModel!.data!.email!;
              phoneController.text = cubit.loginModel!.data!.phone!;
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          if (state is ShopLoadingUpdateUserDataState)
                            LinearProgressIndicator(
                              color: Colors.deepOrange,
                            ),
                          SizedBox(
                            height: 50,
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                                '${cubit.loginModel!.data!.image!}'),
                            radius: 50,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          defTextFormFiled(
                            textEditingController: nameController,
                            labelText: 'Name',
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'name musn\'t be empty';
                              }
                              return null;
                            },
                            readOnly: !cubit.isEditing,
                            autofocus: true,
                            prefixIcon: Icon(Icons.person),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          defTextFormFiled(
                            textEditingController: emailController,
                            labelText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email musn\'t be empty';
                              }
                              return null;
                            },
                            readOnly: !cubit.isEditing,
                            prefixIcon: Icon(Icons.email),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          defTextFormFiled(
                            textEditingController: phoneController,
                            labelText: 'Name',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'phone musn\'t be empty';
                              }
                              return null;
                            },
                            readOnly: !cubit.isEditing,
                            prefixIcon: Icon(Icons.phone),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          defButton(
                              text: 'SIGN OUT',
                              onPressed: () {
                                signOut(context);
                              },
                              color: Colors.deepOrange)
                        ],
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                    child:
                        cubit.isEditing ? Icon(Icons.check) : Icon(Icons.edit),
                    onPressed: () {
                      if (cubit.isEditing) {
                        if (formKey.currentState!.validate()) {
                          cubit.updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text);
                        } else {
                          return;
                        }
                      } else {
                        cubit.startEditing();
                      }
                    }),
              );},
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        });
  }
}
