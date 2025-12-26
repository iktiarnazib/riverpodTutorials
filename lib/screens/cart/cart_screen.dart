import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  bool showCoupon = true;

  @override
  Widget build(BuildContext context) {
    final itemProvider = ref.watch(cartProvider);
    // final total = itemProvider.fold(
    //   0,
    //   (sum, item) => sum + item.price,
    // );
    final totalPrice = ref.watch(cartTotalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(children: [
          Column(
            children: itemProvider.map(
              (e) {
                return Container(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Image.asset(
                        e.image,
                        height: 60,
                        width: 60,
                      ),
                      Text('${e.title}...'),
                      const Expanded(child: SizedBox()),
                      Text('\$${e.price}'),
                    ],
                  ),
                );
              },
            ).toList(),
          ),
          if (totalPrice != 0)
            const Divider(
              color: Colors.blue,
              thickness: 2.0,
            ),
          Row(
            children: [
              if (totalPrice != 0) ...[
                const Expanded(child: SizedBox()),
                Text('Total: \$$totalPrice'),
              ]
            ],
          ),
        ]),
      ),
    );
  }
}
