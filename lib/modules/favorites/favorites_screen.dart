import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favoirtes_model.dart';
import 'package:shop_app/shared/components/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          ShopCubit cubit = ShopCubit.get(context);
          return Scaffold(
            body: ConditionalBuilder(
              condition: state is! ShopLoadingFavoritesState,
              builder: (context)=>ListView.separated(
                  itemBuilder: (context,i)=> buildListProduct(cubit.favoritesModel!.data!.data![i].product!,context,),
                  separatorBuilder: (context,i)=> Divider(),
                  itemCount: cubit.favoritesModel!.data!.data!.length
              ),
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
          );
        });
  }

  // Widget buildFavItem(Product model,BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           width: 120,
  //           height: 120,
  //           child: Stack(
  //             alignment: AlignmentDirectional.bottomStart,
  //             children: [
  //               Image(
  //                 image: NetworkImage('${model.image}'),
  //                 width: 120,
  //                 height: 120,
  //
  //               ),
  //               if (model.discount != 0)
  //                 Container(
  //                   color: Colors.red,
  //                   child: const Padding(
  //                     padding: EdgeInsets.symmetric(horizontal: 8.0),
  //                     child: Text(
  //                       'Discount',
  //                       style: TextStyle(color: Colors.white, fontSize: 10),
  //                     ),
  //                   ),
  //                 )
  //             ],
  //           ),
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Expanded(
  //           child: Container(
  //             height: 120,
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   '${model.name}',
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                   style: const TextStyle(
  //                       fontWeight: FontWeight.bold, fontSize: 15, height: 1.3),
  //                 ),
  //                 Spacer(),
  //                 Row(
  //                   children: [
  //                     Text(
  //                       '${model.price}',
  //                       style: const TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 12,
  //                           color: Colors.deepOrange),
  //                     ),
  //                     const SizedBox(
  //                       width: 5,
  //                     ),
  //                     if (model.discount != 0)
  //                       Text(
  //                         '${model.oldPrice}',
  //                         style: const TextStyle(
  //                             fontSize: 10,
  //                             color: Colors.grey,
  //                             decoration: TextDecoration.lineThrough),
  //                       ),
  //                     const Spacer(),
  //                     CircleAvatar(
  //                       backgroundColor: ShopCubit.get(context).favoirtes[model.id]!? Colors.deepOrange : Colors.grey[400],
  //                       radius: 15,
  //                       child: IconButton(
  //                           padding: EdgeInsets.zero,
  //                           onPressed: () {
  //                             ShopCubit.get(context).changeFavorites(productId: model.id!);
  //                           },
  //                           icon: const Icon(
  //                             Icons.favorite_border,
  //                             size: 18,
  //                             color: Colors.white,
  //                           )),
  //                     )
  //                   ],
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
