import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateToReplacement(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));

Widget defTextFormFiled(
    {TextEditingController? textEditingController,
    Widget? prefixIcon,
    Widget? suffixIcon,
    String? labelText,
    String? Function(String?)? validator,
    bool password = false,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool readOnly = false,
    bool autofocus = false,
    String? hintText,
    Function(String)? onSubmitted,
    Function(String)? onChanged}) {
  return TextFormField(
    autofocus: autofocus,
    style: TextStyle(fontWeight: FontWeight.bold),
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: hintText,
      border: OutlineInputBorder(),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: labelText,
    ),
    validator: validator,
    obscureText: password,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    readOnly: readOnly,
    onChanged: onChanged,
    onFieldSubmitted: onSubmitted,
  );
}

Widget defButton(
    {required String text,
    required void Function() onPressed,
    Color textColor = Colors.white,
    Color? color}) {
  return Container(
    width: double.infinity,
    height: 50,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(5),
    ),
    child: MaterialButton(
      onPressed: onPressed,
      child: Text(
        '$text',
        style: TextStyle(
          color: textColor,
        ),
      ),
    ),
  );
}

defToast(
    {required String msg,
    Toast? toastLength,
    ToastGravity? gravity,
    int timeInSecForIosWeb = 5,
    Color backgroundColor = Colors.deepOrange,
    Color textColor = Colors.white,
    double fontSize = 16}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize);
}

Widget buildListProduct(model,BuildContext context,{bool isOldPrice = true}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 120,
          height: 120,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120,
                height: 120,

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
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Container(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15, height: 1.3),
                ),
                Spacer(),
                Row(
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
                    if (isOldPrice && model.discount != 0)
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
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
