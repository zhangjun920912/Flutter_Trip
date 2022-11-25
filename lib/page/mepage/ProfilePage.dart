import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  String name = '';

  ProfilePage(this.name, {super.key}) ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  const Text('个人信息'),
        actions: <Widget>[
           IconButton(icon:const Icon(Icons.share), onPressed: sharePlatform)
        ],
      ),
      body:  ListView(
        children: <Widget>[
           Image.network('https://www.suanya.cn/dist/img/home-banner.a85336b.png', fit: BoxFit.fill),
           TextButton(
              child: Text(name),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  ///third platform share

  void sharePlatform() {
  }
}
