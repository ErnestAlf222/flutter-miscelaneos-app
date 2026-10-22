import 'package:flutter/material.dart';

class AdrewardedScreen extends StatelessWidget {
  const AdrewardedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Full Screen'),
      ),
      body: const Center(
        child: Text('Hola'),
      ),
    );
  }
}