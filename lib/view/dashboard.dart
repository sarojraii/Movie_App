import 'package:flutter/material.dart';
import 'package:movie_app/view/explore_page.dart';
import 'package:movie_app/view/home_page.dart';
import 'package:movie_app/view/my_list.dart';
import 'package:movie_app/view/profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List navpages = [HomePage(), ExplorePage(), MyList(), ProfilePage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navpages.elementAt(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: selectIndex,
        fixedColor: Colors.blue,
        backgroundColor: Colors.blueGrey[800],
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: "Profile"),
        ],
      ),
    );
  }

  selectIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
