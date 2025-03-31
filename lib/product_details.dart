import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoping_app/cart_provider.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int selectedSize = 0;
  void onTap() {
    if (selectedSize != 0) {
      Provider.of<CartProvider>(context, listen: false).addProducts({
        'id': widget.product['id'],
        'company': widget.product['company'],
        'title': widget.product['title'],
        'model': widget.product['model'],
        'price': widget.product['price'],
        'sizes': selectedSize,
        'imageURL': widget.product['imageURL'],
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Product Added Successfully!')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select a size!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.product['model'] as String,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 32), // Replace Spacer(flex: 1)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                widget.product['imageURL'] as String,
                height:
                    MediaQuery.of(context).size.height *
                    0.4, // Adjust height dynamically
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.contain,
                // height: 450,
              ),
            ),
            SizedBox(height: 32), // Replace Spacer(flex: 2)
            Container(
              height: 250,
              decoration: BoxDecoration(
                color: Color.fromRGBO(245, 247, 249, 1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        '\$${widget.product['price']}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,

                          itemCount:
                              (widget.product['sizes'] as List<int>).length,
                          itemBuilder: (context, index) {
                            final size =
                                (widget.product['sizes'] as List<int>)[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = size;
                                  });
                                },
                                child: Chip(
                                  label: Text(size.toString()),
                                  backgroundColor:
                                      selectedSize == size
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.primary
                                          : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: ElevatedButton.icon(
                          onPressed: onTap,
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            shadowColor: (Colors.black),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            minimumSize: Size(double.infinity, 50),
                          ),

                          icon: Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.black,
                            size: 18,
                          ),
                          label: Text(
                            'Add To Cart',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
