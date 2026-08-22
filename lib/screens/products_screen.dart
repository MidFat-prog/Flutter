import 'package:flutter/material.dart';
import '../widgets/ProductCard.dart';

/// Products tab — demonstrates GridView + the reusable ProductCard widget.
class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  static const List<Product> _products = [
    Product(name: 'Backpack', price: '\$39.99', icon: Icons.backpack_outlined),
    Product(name: 'Headphones', price: '\$59.99', icon: Icons.headphones_outlined),
    Product(name: 'Watch', price: '\$89.99', icon: Icons.watch_outlined),
    Product(name: 'Sneakers', price: '\$74.99', icon: Icons.directions_run_outlined),
    Product(name: 'Sunglasses', price: '\$24.99', icon: Icons.wb_sunny_outlined),
    Product(name: 'Camera', price: '\$149.99', icon: Icons.camera_alt_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        itemCount: _products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 14,
          crossAxisSpacing: 14,
          childAspectRatio: 0.78,
        ),
        itemBuilder: (context, index) {
          final product = _products[index];
          return ProductCard(
            product: product,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tapped ${product.name}')),
              );
            },
          );
        },
      ),
    );
  }
}