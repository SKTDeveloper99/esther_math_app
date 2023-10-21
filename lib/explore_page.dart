import 'package:esther_math_app/algebra.dart';
import 'package:esther_math_app/number_theory.dart';
import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Explore Page"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
            },
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Next page'),
                    ),
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SearchAnchor(
                          builder: (BuildContext context, SearchController controller) {
                            return SearchBar(
                              controller: controller,
                              padding: const MaterialStatePropertyAll<EdgeInsets>(
                                  EdgeInsets.symmetric(horizontal: 16.0)),
                              onTap: () {
                                controller.openView();
                              },
                              onChanged: (_) {
                                controller.openView();
                              },
                              leading: const Icon(Icons.search),
                            );
                          },
                          suggestionsBuilder: (BuildContext context, SearchController controller) {
                            return <Widget> {
                               Padding(
                                  padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                        child: Text("#Algebra"),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const AlgebraPage()),
                                        );
                                      },
                                    ),
                                    GestureDetector(
                                      child: Text("#Number Theory"),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const NumberTheoryPage()),
                                        );
                                      },
                                    ),
                                    Text("#Geometry"),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text("#Combinatorics"),
                                    Text("#Others"),
                                    // Text("data 6"),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 240,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  physics: const PageScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    if(index % 2 == 0) {
                                      return _buildCarousel(context, index ~/ 2);
                                    }
                                    else {
                                      return Divider();
                                    }
                                  },
                                ) ,
                              ),
                              SizedBox(
                                height: 240,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  physics: const PageScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    if(index % 2 == 0) {
                                      return _buildCarousel(context, index ~/ 2);
                                    }
                                    else {
                                      return Divider();
                                    }
                                  },
                                ) ,
                              ),
                              SizedBox(
                                height: 240,
                                child: ListView.builder(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  physics: const PageScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    if(index % 2 == 0) {
                                      return _buildCarousel(context, index ~/ 2);
                                    }
                                    else {
                                      return Divider();
                                    }
                                  },
                                ) ,
                              ),
                            };
                      }),
                    ),
                  );
                },
              ));
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

Widget _buildCarousel(BuildContext context, int carouselIndex) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Text('Carousel $carouselIndex'),
      SizedBox(
        // you may want to use an aspect ratio here for tablet support
        height: 200.0,
        child: PageView.builder(
          // store this controller in a State to save the carousel scroll position
          controller: PageController(viewportFraction: 0.8),
          itemBuilder: (BuildContext context, int itemIndex) {
            return _buildCarouselItem(context, carouselIndex, itemIndex);
          },
        ),
      )
    ],
  );
}

Widget _buildCarouselItem(BuildContext context, int carouselIndex, int itemIndex) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    ),
  );
}

