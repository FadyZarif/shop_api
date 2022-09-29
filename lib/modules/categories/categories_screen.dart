import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          ShopCubit cubit = ShopCubit.get(context);
          return ListView.separated(
              itemBuilder: (context,i)=>buildCategoryItem(cubit.categoriesModel!.data!.data[i]!),
              separatorBuilder: (context,i)=>Divider(),
              itemCount: cubit.categoriesModel!.data!.data.length
          );
        },

      )
    );
  }
  Widget buildCategoryItem(DataModel model){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            '${model.name}',
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
            overflow: TextOverflow.ellipsis,
          ),
          Spacer(),
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios,))
        ],
      ),
    );
  }
}
