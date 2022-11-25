import 'package:flutter/material.dart';

import 'ProfilePage.dart';

class MePage extends StatelessWidget {
  const MePage();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar:  AppBar(
          title: const Text('我的'),
          actions: <Widget>[
             IconButton(
                icon:  const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                     MaterialPageRoute(
                        builder: (context) =>  ProfilePage("智行火车票")),
                  );
                }),
          ],
        ),
        body: Container(),
      ),
      theme:  ThemeData(
        primaryColor: const Color(0xFF198CFF),
      ),
    );
  }
}
