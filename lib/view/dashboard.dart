import 'package:ad_package/ad_package.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/view/explore_page.dart';
import 'package:movie_app/view/profile_page.dart';
import 'package:movie_app/view/provider_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';
import 'my_list.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void initState() {
    showAd();
    super.initState();
  }

  callBack() {
    Navigator.pop(context);
  }

  showAd() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var adShown = prefs.getBool('adShown');
      if (adShown ?? false) {
      } else {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return Ads(
                okButtonpressed: () {
                  prefs.setBool('adShown', true);
                },
                adType: AdType.movieAd,
              );
            },
          );
        }
      }
    });
  }

  List navpages = [
    const HomePage(),
    const ExplorePage(),
    const ProviderList(),
    const ProfilePage()
  ];
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
        items: const [
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
