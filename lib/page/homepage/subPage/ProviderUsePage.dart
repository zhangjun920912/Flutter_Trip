import 'package:flutter/material.dart';

class ProviderUsePage extends StatefulWidget {
  const ProviderUsePage({super.key});

  @override
  ProviderUsePageState createState() => ProviderUsePageState();
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
