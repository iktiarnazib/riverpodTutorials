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
    final cartProduct = ref.watch(cartNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Garage Sale Products'),
        actions: const [CartIcon()],
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
                              .read(cartNotifierProvider.notifier)
                              .removeProduct(allProducts[index]);
                        },
                        child: const Text('Remove')),
                  if (!cartProduct.contains(allProducts[index]))
                    OutlinedButton(
                        onPressed: () {
                          //to access method, we use ref.read(notifiername.notifier).methodName to make changes
                          ref
                              .read(cartNotifierProvider.notifier)
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
