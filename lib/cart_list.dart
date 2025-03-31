import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;
    return Scaffold(
      appBar: AppBar(title: Text('Cart Page')),
      body:
          cart.isEmpty
              ? Center(
                child: Text(
                  'Cart is Empty!!!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
              : ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final cartItem = cart[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        cartItem['imageURL'] as String,
                      ),
                      radius: 30,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                'Delete Product ',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              content: Text(
                                'Are You Sure you want to remove the product?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'No',
                                    style: TextStyle(
                                      color: (Colors.blue),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    context.read<CartProvider>().removeProducts(
                                      cartItem,
                                    );

                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(
                                      color: (Colors.red),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete_rounded, color: Colors.red),
                    ),
                    title: Text(
                      cartItem['model'].toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text('Size: ${cartItem['sizes']}'),
                  );
                },
              ),
    );
  }
}
