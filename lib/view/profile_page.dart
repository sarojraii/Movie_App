import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/provider/provider.dart';
import 'package:movie_app/view/dashboard.dart';
import 'package:movie_app/view/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int index = 3;

  String emailController = '';
  String pwController = '';

  @override
  void initState() {
    super.initState();
    userInput();
  }

  Future<void> userInput() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      emailController = sp.getString('userInfo') ?? '';
      pwController = sp.getString('password') ?? '';
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          SharedPreferences pref =
                              await SharedPreferences.getInstance();
                          pref.setString('userInfo', '');
                          _auth.signOut();
                          if (context.mounted) {
                            context.read<DashboardProvider>().selectIndex(0);
                            context.read<MovieProvider>().movie.clear();
                          }

                          if (context.mounted) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const LoginPage();
                                },
                              ),
                            );
                          }
                        },
                        child: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                backgroundImage: AssetImage('image/me.jpg'),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Center(
              child: Text(
                emailController,
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                pwController,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const PremiumPackageWidget(),
            const UserInfoWidget(),
          ],
        ),
      ),
    );
  }
}

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          MyProfile(
            icons: Icons.person,
            text: 'Edit Profile',
          ),
          Column(
            children: [
              MyProfile(
                icons: Icons.notifications,
                text: 'Notification',
              ),
            ],
          ),
          Column(
            children: [
              MyProfile(
                icons: Icons.downloading_outlined,
                text: 'Download',
              ),
            ],
          ),
          Column(
            children: [
              MyProfile(
                icons: Icons.security,
                text: 'Security',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PremiumPackageWidget extends StatelessWidget {
  const PremiumPackageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blueGrey[900],
                border: Border.all(color: Colors.red.shade700, width: 3)),
            height: 100,
            child: const Column(
              children: [
                Center(
                  child: Text(
                    'Join Premium',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.workspace_premium,
                        size: 50,
                        color: Colors.red,
                      ),
                      Text(
                        'Enjoy watching Full-HD movies. \nwithout restrictions and without ads.',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.red,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class MyProfile extends StatelessWidget {
  final IconData icons;
  final String text;

  const MyProfile({required this.icons, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey[800],
          ),
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  icons,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                width: 200,
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
