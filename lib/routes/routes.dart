import 'package:shop_app/screens/product_details_screen.dart';

class Routes {
  static String productDetailScreen = '/product-details-screen';

  static getRoutes() {
    return {
      productDetailScreen: (context) => const ProductDetailsScreen(),
    };
  }
}
