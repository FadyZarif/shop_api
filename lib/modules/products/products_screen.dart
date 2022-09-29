import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopErrorChangeFavoritesState){
          defToast(
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              fontSize: 14,
              timeInSecForIosWeb: 3,
              msg: '${state.changeFavoritesModel!.message}',
              backgroundColor: Colors.red
          );
        }
        if(state is ShopSuccessChangeFavoritesState){
          defToast(
              toastLength: Toast.LENGTH_SHORT,
              textColor: Colors.white,
              gravity: ToastGravity.BOTTOM,
              fontSize: 14,
              timeInSecForIosWeb: 3,
              msg: '${state.changeFavoritesModel!.message}',
              backgroundColor:  Colors.green
          );
        }
        if (state is ShopErrorCategoriesState){
          print(state.error.toString());
        }
      },
      builder: (context, state) {
        ShopCubit cubit = ShopCubit.get(context);
        return Scaffold(
            body: ConditionalBuilder(
                condition: cubit.homeModel != null && cubit.categoriesModel !=null,
                builder: (context) {
                  return productBuilder(cubit.homeModel!,cubit.categoriesModel!,context);
                },
                fallback: (context) =>
                const Center(
                  child: CircularProgressIndicator(),
                )));
      },
    );
  }

  Widget productBuilder(HomeModel model,CategoriesModel categoriesModel,BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CarouselSlider(
            items: model.data?.banners.map((e) {
              return Image(
                image: NetworkImage(
                  '${e.image}',
                ),
                fit: BoxFit.fitWidth,
              );
            }).toList(),
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              initialPage: 0,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
            )),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) =>buildCategoryItem(categoriesModel.data!.data[i]!),
                    separatorBuilder: (context, i)=>VerticalDivider(),
                    itemCount: categoriesModel.data!.data.length,


                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'New Products',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 0.63,
            children: List.generate(
              model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
            ),
          ),
        )
      ]),
    );
  }

  Widget buildCategoryItem(DataModel model) =>
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
           Image(
            image: NetworkImage(
              '${model.image}',
            ),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100,
            height: 18,
            color: Colors.black.withOpacity(0.7),
            child:  Text('${model.name}',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold)),
          )
        ],
      );

  Widget buildGridProduct(ProductModel model,BuildContext context) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model.image}'),
                  width: double.infinity,
                  // fit: BoxFit.cover,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Discount',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15, height: 1.3),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.deepOrange),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  if (model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: ShopCubit.get(context).favoirtes[model.id]!? Colors.deepOrange : Colors.grey[400],
                    radius: 15,
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(productId: model.id!);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 18,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
