import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'main.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productId;

  ProductDetailsPage({required this.productId});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set AppBar color to transparent
        elevation: 0, // Remove AppBar elevation
        title: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.withOpacity(0.5)),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search,
                  color: Colors.grey), // Add search icon before hintText
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: Colors.black),
            onPressed: () {
              // Navigate to wishlist
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined, color: Colors.black),
            onPressed: () {
              // Navigate to cart
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            child: PhotoView(
              imageProvider:
                  AssetImage('assets/images/product_${widget.productId}.jpg'),
            ),
          ),

          // Product details and description
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Title',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  'Product Description',
                  style: TextStyle(fontSize: 16),
                ),
                // Add more product details here
              ],
            ),
          ),

// Tabs (About Item, Reviews)
          DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabBar(
                  labelColor: Colors.green, // Set selected tab text color to green
                  unselectedLabelColor: Colors.black, // Set unselected tab text color to black
                  indicatorColor: Colors.green, // Set selected tab line color to green
                  tabs: const [
                    Tab(text: 'About Item'),
                    Tab(text: 'Reviews'),
                  ],
                ),
                Container(
                  height: 200, // Set the desired height for the tab content
                  child: const TabBarView(
                    children: [
                      // About Item tab content
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('About Item content'),
                      ),
                      // Reviews tab content
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Text('Reviews content'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),


// Ratings
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reviews & Ratings',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '4.9',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.star, color: Colors.yellow[600]),
                      SizedBox(width: 8),
                      Text(
                        '2000 Reviews',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: List.generate(
                      5,
                          (index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text('${5 - index}'),
                            Icon(Icons.star, color: Colors.yellow[600], size: 16),
                            SizedBox(width: 8),
                            SizedBox(
                              width: 100,
                              child: LinearProgressIndicator(
                                value: (5 - index) / 5,
                                backgroundColor: Colors.grey[300],
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow[600]!),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text('(${(5 - index) * 100})'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),



// Recommended products
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Products',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 16),
                        child: ProductCard(index: index),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60, // Set the desired height for the bottom sheet
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Price:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('\$100', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              Stack(
                children: [
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle cart button action
                        },
                        child: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle buy now button action
                        },
                        child: Text('Buy Now', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 5,
                    child: Padding(
                      padding: EdgeInsets.only(left: 65), // Adjust the value to control the position of the second button
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle buy now button action
                        },
                        child: Text('Buy Now', style: TextStyle(color: Colors.white)),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
