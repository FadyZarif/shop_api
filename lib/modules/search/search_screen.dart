import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  TextEditingController searchController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                elevation: 5,
                toolbarHeight: 100,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                      key: formKey,
                      child: defTextFormFiled(
                          textEditingController: searchController,
                          prefixIcon: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            onPressed: () {
                              searchController.text = '';
                            },
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter word';
                            }
                            return null;
                          },
                          hintText: 'Search...',
                          onSubmitted: (value) {
                            SearchCubit.get(context).search(q: value);
                          },
                          onChanged: (value) {
                            SearchCubit.get(context).search(q: value);
                          })),
                ),
              ),
              body: Column(
                children: [
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  if (state is SearchSuccessState)
                   Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, i) => buildListProduct(
                                  SearchCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .data![i],
                                  context,
                                isOldPrice: false
                              ),
                              separatorBuilder: (context, i) => Divider(),
                              itemCount: SearchCubit.get(context)
                                  .searchModel!
                                  .data!
                                  .data!
                                  .length),
                        )
                ],
              ),
            );
          }),
    );
  }
}
