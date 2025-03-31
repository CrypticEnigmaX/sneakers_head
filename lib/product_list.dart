import 'package:flutter/material.dart';
import 'package:shoping_app/cart.dart';
import 'package:shoping_app/global_variables.dart';
import 'package:shoping_app/product_details.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const [
    'All',
    'Nike',
    'Addidas',
    'Converse',
    'ASICS',
    'Vans',
    'Balenciaga',
    'Rick Owens',
  ];
  String selectedFilter = '';
  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromRGBO(225, 225, 225, 1)),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sneakers\nHead',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: border,
                    enabledBorder: border,
                    focusedBorder: border,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 75,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              itemBuilder: (context, index) {
                final filter = filters[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor:
                          selectedFilter == filter
                              ? Theme.of(context).colorScheme.primary
                              : Color.fromRGBO(245, 247, 249, 1),
                      label: Text(filter, style: TextStyle(fontSize: 16)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),

                      side: BorderSide(color: Color.fromRGBO(245, 247, 249, 1)),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ProductDetails(product: product);
                        },
                      ),
                    );
                  },
                  child: ProductCart(
                    title: product['model'] as String,
                    price: product['price'] as double,
                    image: product['imageURL'] as String,
                    backgroundColor:
                        index.isEven
                            ? Color.fromRGBO(216, 240, 253, 1)
                            : Color.fromRGBO(245, 247, 249, 1),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
