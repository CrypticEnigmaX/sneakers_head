import 'package:flutter/material.dart';

class ProductCart extends StatelessWidget {
  final String title;
  final double price;
  final String image;
  final Color backgroundColor;
  const ProductCart({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(40),
      ),
      margin: EdgeInsets.all(20),

      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          SizedBox(height: 5),
          Text('\$$price', style: Theme.of(context).textTheme.bodySmall),
          SizedBox(height: 5),
          Center(child: Image.asset(image, height: 500)),
        ],
      ),
    );
  }
}
