import 'package:flutter/material.dart';


class AdFullScreen extends StatelessWidget {
  const AdFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Full Screen'),
      ),
      body: const Center(
        child: Text('Ya puedes regresar a esta pantalla'),
      ),
    );
  }
}