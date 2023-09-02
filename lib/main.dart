import 'package:flutter/material.dart';
import 'package:sprint3/list.dart';
import 'package:sprint3/map.dart';
import 'package:sprint3/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CarScreen(),
    );
  }
}

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

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
      body: Column(
        children: <Widget>[
          Image.network(
            'https://images.pexels.com/photos/14438397/pexels-photo-14438397.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.lock_open),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.power_settings_new),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RegisterCombustivelScreen()),
                    );
                  },
                  iconSize: 48,
                ),
              ),
              const SizedBox(width: 20),
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.lock),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.local_gas_station),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListCarsScreen()),
                    );
                  },
                  iconSize: 28,
                ),
                const SizedBox(height: 4),
                const Text('Abastecimento', style: TextStyle(fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.directions_car),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.explore),
              onPressed: () {
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MapScreen()),
                    );
              },
            ),
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
