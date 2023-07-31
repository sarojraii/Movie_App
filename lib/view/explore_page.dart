import 'package:flutter/material.dart';
import 'package:movie_app/view/my_list.dart';
import 'package:movie_app/view/home_page.dart';
import 'package:movie_app/view/profile_page.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    MyRow(
                      text: 'Action',
                    ),
                    MyRow(
                      text: 'Adventure',
                    ),
                    MyRow(
                      text: 'Horror',
                    ),
                    MyRow(
                      text: 'Sci-fi',
                    ),
                    MyRow(
                      text: 'Comedy',
                    ),
                    MyRow(
                      text: 'Thriller',
                    ),
                  ],
                ),
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaperaccess.com/full/267486.jpg',
                imageUrl2: 'https://wallpaperaccess.com/full/259316.jpg',
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaperaccess.com/full/267512.jpg',
                imageUrl2: 'https://wallpaperaccess.com/full/267592.jpg',
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaper.dog/large/20494210.jpg',
                imageUrl2: 'https://wallpaper.dog/large/20494129.jpg',
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaper.dog/large/17173541.jpg',
                imageUrl2: 'https://wallpaperaccess.com/full/267592.jpg',
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaperaccess.com/full/267486.jpg',
                imageUrl2: 'https://wallpaperaccess.com/full/259316.jpg',
              ),
              const MyComponents(
                imageUrl1: 'https://wallpaper.dog/large/20494210.jpg',
                imageUrl2: 'https://wallpaper.dog/large/20494129.jpg',
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.blue[100],
          labelTextStyle: const MaterialStatePropertyAll(
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

            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyList()),
              );
            }
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
            if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
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

class MyComponents extends StatefulWidget {
  final String imageUrl1;
  final String imageUrl2;
  const MyComponents(
      {required this.imageUrl1, required this.imageUrl2, super.key});

  @override
  State<MyComponents> createState() => _MyComponentsState();
}

class _MyComponentsState extends State<MyComponents> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl1),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage(widget.imageUrl2),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyRow extends StatelessWidget {
  final String text;

  const MyRow({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              height: 35,
              width: 90,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
