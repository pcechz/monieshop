import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:monieshop/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) => ScrollControllerNotifier(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
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
      body: NestedScrollView(
        controller: Provider.of<ScrollControllerNotifier>(context).controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, realIdx) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/product_$index.jpg',
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              fit: BoxFit.cover,
                            ),

                            Positioned(
                              left: 16,
                              top: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    '#FashionDay',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    '80% OFF',
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.3, // Set a maxWidth to wrap the text
                                    child: const Text(
                                      'Discover fashion that suit your style',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle button action
                                    },
                                    child: const Text(
                                      'Check this out',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 1.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (context, index) {
                          return CategoryButton(index: index);
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ];
        },
        body: BestSalesSection(),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final int index;

  CategoryButton({required this.index});

  final List<Map<String, Object>> categories = [
    {
      'icon': Icons.category_outlined,
      'text': 'Category',
    },
    {
      'icon': Icons.history_outlined,
      'text': 'Transactions',
    },
    {
      'icon': Icons.money_outlined,
      'text': 'Transfer',
    },
    {
      'icon': Icons.receipt_outlined,
      'text': 'Bills',
    },
    {
      'icon': Icons.data_usage_outlined,
      'text': 'Data Plan',
    },
    {
      'icon': Icons.flight_outlined,
      'text': 'Flight',
    },
    {
      'icon': Icons.add_ic_call_outlined,
      'text': 'Top Up',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              // Navigate to the category page
            },
            icon: Icon(
              categories[index]['icon'] as IconData,
              size: 24,
            ),
          ),
          SizedBox(height: 5),
          Text(
            categories[index]['text'] as String,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class BestSalesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: StickyHeader(
            header: _BestSalesHeader(),
            content: Padding(
              padding: EdgeInsets.all(8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.6,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductCard(index: index);
                },
                itemCount: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BestSalesHeader extends StatelessWidget {
  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Best Sale Product',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              // Handle "See more" action
            },
            child: Text(
              'See more',
              style: TextStyle(fontSize: 16, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }

  double get height => _key.currentContext?.size?.height ?? 0;
}

class BestSalesHeaderDelegate extends SliverPersistentHeaderDelegate {
  final _BestSalesHeader _header;

  BestSalesHeaderDelegate(this._header);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return _header;
  }

  @override
  double get maxExtent => _header.height;

  @override
  double get minExtent => _header.height;

  @override
  bool shouldRebuild(BestSalesHeaderDelegate oldDelegate) => false;
}

class ProductCard extends StatelessWidget {
  final int index;

  ProductCard({required this.index});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(productId: index),
          ),
        );
      },
      child: Stack(
        children: [
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/product_$index.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shirts',
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Best Seller',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Product ${index + 1}',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '4.9/2000',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          Text(
                            '\$${(index + 1) * 10}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle the like action
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ScrollControllerNotifier extends ChangeNotifier {
  ScrollController _controller;

  ScrollControllerNotifier() : _controller = ScrollController() {
    _controller.addListener(() {
      notifyListeners();
    });
  }

  ScrollController get controller => _controller;
}
