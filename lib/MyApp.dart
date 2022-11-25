import 'package:flutter/material.dart';
import 'package:zjflutter_practise/page/cartpage/CartPage.dart';
import 'package:zjflutter_practise/page/homepage/HomePage.dart';
import 'package:zjflutter_practise/page/mepage/MePage.dart';
import 'package:zjflutter_practise/page/shoppage/ShopPage.dart';


class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: _title,
      home:  MyStatefulWidget(),
      theme:  ThemeData(primaryColor: Color(0xFF198CFF)),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyStatefulWidgetState();
  }
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const optionStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ShopPage(),
    CartPage(),
    MePage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_mall), label:'商品'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_grocery_store), label:'购物车'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label:'我的'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF198CFF),
        unselectedItemColor: Colors.grey[400],
        onTap: _onItemTapped,
        showUnselectedLabels: true,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        elevation: 4.0,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
