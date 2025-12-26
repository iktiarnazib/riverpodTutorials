import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_files/models/product.dart';

part 'cart_provider.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  //Intiial value
  @override
  Set<Product> build() {
    return const {};
  }

//Method to update the state
  void addProduct(Product product) {
    if (!state.contains(product)) {
      state = {
        ...state,
        product
      }; //literally replacing the old cartNotifier build and making new one and replacing old one
    }
  }

  void removeProduct(Product product) {
    if (state.contains(product)) {
      state =
          state //literally replacing the old cartNotifier build and making new one and replacing old one
              .where(
                (p) => p.id != product.id,
              )
              .toSet();
    }
  }
}

//manually written providerNotifier
// final cartNotifierProvider = NotifierProvider<CartNotifier, Set<Product>>(
//   () {
//     return CartNotifier();
//   },
// );

//Provider Dependent Provider
@riverpod
int cartTotal(ref) {
  final cartProducts = ref.watch(cartProvider);

  int total = 0;

  for (Product product in cartProducts) {
    total += product.price;
  }

  return total;
}
