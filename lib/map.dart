import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: const Text('Meu Carro'),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        actions: const [Icon(Icons.account_circle)],
      ),
      body: const Column(children: [
        Text("Bola")
      ]),
    );
  }
}
