import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/product.dart';
import 'package:shop_app/screens/product_details_screen.dart';

import '../provider/auth.dart';
import '../provider/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          header: Container(
            height: 30,
            color: Colors.red,
            child: GridTileBar(
              trailing: Consumer<Product>(
                builder: (ctx, product, _) => IconButton(
                  icon: Icon(
                    product.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_border,
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                  onPressed: () {
                    product.toggleFavouriteStatus(
                      authData.token!,
                      authData.userId,
                    );
                  },
                ),
              ),
              leading: const CircleAvatar(),
            ),
          ),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProductDetailsScreen.routeName,
                  arguments: product.id,
                );
              },
              child: Hero(
                tag: product.id,
                child: FadeInImage(
                  placeholder: const AssetImage(
                    'asset/images/product-placeholder.png',
                  ),
                  image: NetworkImage(
                    product.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            leading: Consumer<Product>(
              builder: (ctx, product, _) => IconButton(
                icon: Icon(
                  product.isFavourite ? Icons.favorite : Icons.favorite_border,
                ),
                color: Theme.of(context).colorScheme.secondary,
                onPressed: () {
                  product.toggleFavouriteStatus(
                    authData.token!,
                    authData.userId,
                  );
                },
              ),
            ),
            subtitle: Text(
              product.price.toString(),
              textAlign: TextAlign.center,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Added item to cart!',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                        label: 'UNDO',
                        onPressed: () {
                          cart.removeSingleItem(product.id);
                        }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}