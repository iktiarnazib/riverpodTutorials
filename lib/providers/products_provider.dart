import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_files/models/product.dart';

const List<Product> allProducts = [
  Product(
      id: '1',
      title: 'Backpack',
      price: 20,
      image: 'assets/products/backpack.png'),
  Product(id: '2', title: 'Drum', price: 14, image: 'assets/products/drum.png'),
  Product(
      id: '3', title: 'Guiter', price: 30, image: 'assets/products/guitar.png'),
  Product(
      id: '4', title: 'jeans', price: 16, image: 'assets/products/jeans.png'),
  Product(
      id: '5', title: 'karati', price: 19, image: 'assets/products/karati.png'),
  Product(
      id: '6', title: 'shorts', price: 22, image: 'assets/products/shorts.png'),
  Product(
      id: '7', title: 'skates', price: 25, image: 'assets/products/skates.png'),
  Product(
      id: '8',
      title: 'suitcase',
      price: 40,
      image: 'assets/products/suitcase.png'),
];

final productsProvider = Provider(
  (ref) {
    return allProducts;
  },
);

final reducedProductProvider = Provider(
  (ref) {
    return allProducts.where((P) => P.price < 20).toList();
  },
);
