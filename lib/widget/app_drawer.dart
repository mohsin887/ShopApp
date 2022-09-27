import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/provider/auth.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            title: const Text('Shop'),
            leading: const Icon(Icons.shop),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Orders'),
            leading: const Icon(Icons.payment),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(OrderScreen.routeName);
              // Navigator.of(context).pushReplacement(
              // //   CustomRoute(builder: (ctx) => const OrderScreen()),
              // );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Manage Products'),
            leading: const Icon(Icons.edit),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.routeName);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
