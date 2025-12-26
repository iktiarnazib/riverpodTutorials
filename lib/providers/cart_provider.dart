import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/product.dart';

class CartNotifier extends Notifier<Set<Product>> {
  //Intiial value
  @override
  Set<Product> build() {
    return const {
      Product(
          id: '2', title: 'Drum', price: 14, image: 'assets/products/drum.png')
    };
  }

//Method to update the state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {...state, product};
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state = state
          .where(
            (p) => p.id != product.id,
          )
          .toSet();
    }
  }
}

//manually written providerNotifier
final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(
  () {
    return CartNotifier();
  },
);
