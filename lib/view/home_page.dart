import 'package:flutter/material.dart';
import 'package:movie_app/view/explore_page.dart';
import 'package:movie_app/view/my_list.dart';
import 'package:movie_app/view/profile_page.dart';

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
              Stack(
                children: [
                  const Image(
                    image: NetworkImage(
                      'https://wallpaperaccess.com/full/88450.jpg',
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    left: 300,
                    child: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    top: 20,
                    left: 350,
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  const Positioned(
                    bottom: 55,
                    left: 10,
                    child: Column(
                      children: [
                        Text(
                          "Black Panther",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          "Action, Superhero, sci-fi",
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    left: 5,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                              child: Text(
                                'Play',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 30,
                            width: 90,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(15)),
                            child: const Center(
                              child: Text(
                                '+ List',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top 10 Movies This Week",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue[100],
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(fontSize: 14),
          ),
        ),
        child: NavigationBar(
          height: 60,
          backgroundColor: Colors.blueGrey[900],
          selectedIndex: index,
          onDestinationSelected: (int newIndex) {
            setState(() {
              index = newIndex;
            });
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyList()),
              );
            }
            if (index == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            }
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            NavigationDestination(
              icon: Icon(Icons.list),
              label: 'My List',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
