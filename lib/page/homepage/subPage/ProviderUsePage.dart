import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProviderUsePage extends StatefulWidget {
  @override
  ProviderUsePageState createState() => new ProviderUsePageState();
}

class ProviderUsePageState extends State<ProviderUsePage> {
  ProviderUsePageState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider的使用"),
      ),
      body:const Text("sky122"),
    );
  }
}
