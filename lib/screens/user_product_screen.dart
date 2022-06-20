import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widget/app_drawer.dart';
import 'package:shop_app/widget/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product';

  const UserProductScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    print('rebuilding');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (context, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Consumer<Products>(
                      builder: (ctx, productData, _) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ListView.builder(
                            itemCount: productData.items.length,
                            itemBuilder: (_, i) => Column(
                              children: [
                                UserProductItem(
                                    id: productData.items[i].id,
                                    title: productData.items[i].title,
                                    imageUrl: productData.items[i].imageUrl),
                                const Divider(),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }),
    );
  }
}
