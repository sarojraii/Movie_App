import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:flutter/material.dart';

class Item {
  final String urlImage;

  Item({required this.urlImage});
}

class Itemed {
  final String urlImages;

  Itemed({required this.urlImages});
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  // void _navigateToExplorePage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ExplorePage(),
  //     ),
  //   );
  // }

  // void _navigateToMyList() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MyList(),
  //     ),
  //   );
  // }

  // void _navigateToProfilePage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => ProfilePage(),
  //     ),
  //   );
  // }

  List<Item> items = [
    Item(
      urlImage: 'https://wallpaperaccess.com/full/259316.jpg',
    ),
    Item(
      urlImage: 'https://wallpaperaccess.com/full/267486.jpg',
    ),
    Item(
      urlImage: 'https://wallpaperaccess.com/full/267512.jpg',
    ),
    Item(
      urlImage: 'https://wallpaperaccess.com/full/267592.jpg',
    ),
  ];

  List<Itemed> itemed = [
    Itemed(
      urlImages: 'https://wallpaperaccess.com/full/267592.jpg',
    ),
    Itemed(
      urlImages: 'https://wallpaperaccess.com/full/267512.jpg',
    ),
    Itemed(
      urlImages: 'https://wallpaperaccess.com/full/267486.jpg',
    ),
    Itemed(
      urlImages: 'https://wallpaperaccess.com/full/259316.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: double.infinity,
                child: Stack(
                  children: [
                    AnotherCarousel(
                      images: const [
                        Stacker(
                          text: 'Black Panther',
                          text2: 'Superhero, Action, Adventure',
                          text3: 'Play',
                          text4: '+ List',
                          imagePath: 'image/panther.jpg',
                        ),
                        Stacker(
                          text: 'Guardian of Galaxy',
                          text2: 'Superhero, Action, Adventure',
                          text3: 'Play',
                          text4: '+ List',
                          imagePath: 'image/gog.jpg',
                        ),
                        Stacker(
                          text: 'Captain America',
                          text2: 'Superhero, Action, Adventure',
                          text3: 'Play',
                          text4: '+ List',
                          imagePath: 'image/captain.jpg',
                        ),
                      ],
                      boxFit: BoxFit.fill,
                      dotSize: 6,
                      indicatorBgPadding: 3.0,
                      animationDuration: const Duration(seconds: 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                          itemCount: items.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => Container(
                            width: 150,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(items[index].urlImage),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20)),
                            margin: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'New Release',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'See all',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  itemCount: items.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                    width: 150,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                itemed[index].urlImages),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(
      //     indicatorColor: Colors.blue[100],
      //     labelTextStyle: MaterialStatePropertyAll(
      //       TextStyle(fontSize: 14),
      //     ),
      //   ),
      //   child: NavigationBar(
      //     height: 60,
      //     backgroundColor: Colors.blueGrey[900],
      //     selectedIndex:
      //         index, // its value determines which tab is active and highlighted in the bottom navigation bar.
      //     onDestinationSelected: (int newIndex) {
      //       setState(() {
      //         index = newIndex;
      //       });
      //       if (index == 1) {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => ExplorePage()),
      //         );
      //       }
      //       if (index == 2) {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => MyList()),
      //         );
      //       }
      //       if (index == 3) {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => ProfilePage()),
      //         );
      //       }
      //     },
      //     destinations: const [
      //       NavigationDestination(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.explore),
      //         label: 'Explore',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.list),
      //         label: 'My List',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(Icons.account_circle),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

class Stacker extends StatelessWidget {
  final String text;
  final String text2;
  final String text3;
  final String text4;
  final String imagePath;

  const Stacker({
    required this.text,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 120,
          left: 10,
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Positioned(
          top: 150,
          left: 10,
          child: Text(
            text2,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        Positioned(
          top: 190,
          left: 10,
          child: Row(
            children: [
              Container(
                height: 27,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                child: Center(
                  child: Text(
                    text3,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Container(
                height: 27,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 2, color: Colors.white)),
                child: Center(
                  child: Text(
                    text4,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
