import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/order.dart' show Orders;
import '../widget/app_drawer.dart';
import '../widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Building Order nOw');
    // final ordersData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error != null) {
              return const Center(
                child: Text('An Error Occurred!'),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, ordersData, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, i) => OrderItem(
                      order: ordersData.orders[i],
                    ),
                    itemCount: ordersData.orders.length,
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
