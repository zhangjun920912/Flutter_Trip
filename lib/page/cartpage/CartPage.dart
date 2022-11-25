import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage();

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        home:  CheckoutPage(),
        theme:  ThemeData(
          primaryColor: Color(0xFF198CFF),
        ));
  }
}

class CheckoutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CheckoutPageState();
  }
}

class CheckoutPageState extends State<CheckoutPage> {
  @override
  Widget build(BuildContext context) {
    var images = [
      'http://n.sinaimg.cn/front/351/w640h511/20181028/IMAa-hnaivxp6318749.jpg',
      'https://img0.baidu.com/it/u=372789594,2344633202&fm=253&fmt=auto&app=120&f=JPEG?w=589&h=500',
      'http://n.sinaimg.cn/sinacn21/328/w687h441/20180801/d853-hhehtqf0969489.png',
      'https://img0.baidu.com/it/u=1498937664,493969290&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889',
      'https://img0.baidu.com/it/u=2409084625,2891916544&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889',
    ];
    return  Scaffold(
      appBar:  AppBar(
        title:  const Text('资源展示'),
        actions: <Widget>[
           IconButton(
              icon:  const Icon(Icons.add_shopping_cart), onPressed: _pushSaved),
        ],
      ),
      body: Swiper(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) {
          return  Image.network(
            images[index],
            fit: BoxFit.fill,
          );
        },
        pagination:  const SwiperPagination(),
        control: null,
        loop: true,
        autoplay: true,
        duration: 300,
        itemWidth: 300.0,
        itemHeight: 240.0,
        layout: SwiperLayout.STACK,
      ),
      backgroundColor: Colors.black,
    );
  }

  void _pushSaved() {}
}
