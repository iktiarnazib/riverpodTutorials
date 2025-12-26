import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/product.dart';
import 'package:riverpod_files/providers/cart_provider.dart';
import 'package:riverpod_files/providers/products_provider.dart';
import 'package:riverpod_files/shared/cart_icon.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Product> allProducts = ref.watch(productsProvider);
    final cartProduct = ref.watch(cartProvider);
    final totalPrice = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        centerTitle: false,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Cart Value:',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Card(
            color: Colors.teal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$$totalPrice',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const CartIcon()
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          itemCount: allProducts.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.9,
          ),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: Colors.blueGrey.withValues(alpha: 0.05),
              child: Column(
                children: [
                  Image.asset(
                    allProducts[index].image,
                    height: 80,
                    width: 80,
                  ),
                  Text(allProducts[index].title),
                  Text('\$${allProducts[index].price}'),
                  if (cartProduct.contains(allProducts[index]))
                    OutlinedButton(
                        onPressed: () {
                          ref
                              .read(cartProvider.notifier)
                              .removeProduct(allProducts[index]);
                        },
                        child: const Text('Remove')),
                  if (!cartProduct.contains(allProducts[index]))
                    OutlinedButton(
                        onPressed: () {
                          //ref.read just accesss the data, doesn't build the entire ui
                          //ref.watch rebuilds the entire ui and looks for changes
                          //ref.read(cartNotifierProvider.notifier) is used for changing the value of cartNotifierprovider value
                          //ref.read(cartNotifierProvider) will be used when we just want to read the data
                          ref
                              .read(cartProvider.notifier)
                              .addProduct(allProducts[index]);
                          //in riverpod when reading read variable, we write ref.watch(provider_Name)
                        },
                        child: const Text('Add to Cart'))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
