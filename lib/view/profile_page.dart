import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int index = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
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
                child: Icon(
                  Icons.person,
                  size: 100,
                ),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            const Center(
              child: Text(
                'Saroj Rai',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const Center(
              child: Text(
                'raii.saroj21@gmail.com',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey[900],
                        border:
                            Border.all(color: Colors.red.shade700, width: 3)),
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
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
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
            ),
            const SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  MyProfile(
                    iconed: Icons.person,
                    text: 'Edit Profile',
                  ),
                  Column(
                    children: [
                      MyProfile(
                        iconed: Icons.notifications,
                        text: 'Notification',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyProfile(
                        iconed: Icons.downloading_outlined,
                        text: 'Download',
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MyProfile(
                        iconed: Icons.security,
                        text: 'Security',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyProfile extends StatelessWidget {
  final IconData iconed;
  final String text;

  const MyProfile({required this.iconed, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: EdgeInsets.all(5.0),
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
                  iconed,
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
