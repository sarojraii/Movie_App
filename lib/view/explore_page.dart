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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
            child: Column(
          children: [
            Text(
              'hello',
              style: TextStyle(fontSize: 72),
            )
          ],
        )),
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
          destinations: [
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
