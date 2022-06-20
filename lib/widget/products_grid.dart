import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widget/product_item.dart';

import '../provider/products.dart';

class ProductGrid extends StatelessWidget {
  final bool showFav;
  const ProductGrid({
    Key key,
    @required this.showFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showFav ? productsData.favouriteItem : productsData.items;
    return GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 3 / 2,
            mainAxisSpacing: 10),
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: products[i],
              child: const ProductItem(
                  // id: products[i].id,
                  // title: products[i].title,
                  // imageUrl: products[i].imageUrl,
                  ),
            ));
  }
}
