import 'package:flutter/material.dart';

var myWebDrawer = Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: const [
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Text('Drawer Header'),
      ),
      ListTile(
        title: Text('Item 1'),
      ),
      ListTile(
        title: Text('Item 2'),
      ),
    ],
  ),
);
