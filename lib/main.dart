import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sprint3/grafic.dart';
import 'package:sprint3/list.dart';
import 'package:sprint3/map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CarScreen(),
    );
  }
}

class CarScreen extends StatelessWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Define o fundo branco
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 8),
              Text(
                'My Ford',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Comfortaa',
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
            ],
          ),
          centerTitle: true,
          actions: const [Icon(Icons.account_circle)],
        ),
        body: ListView(
          children: <Widget>[
            Image.asset(
              'assets/images/ford.jpeg',
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.lock_open,
                      size: 20,
                      color: Color.fromARGB(255, 0, 2, 118),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: Container(
                    width: 70,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 36,
                          color: Color.fromARGB(255, 0, 2, 118),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'start',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(
                              255,
                              0,
                              2,
                              118,
                            ),
                            fontFamily: 'Comfortaa',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.lock,
                      size: 20,
                      color: Color.fromARGB(255, 0, 2, 118),
                    ),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ListCarsScreen()),
                      );
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_gas_station,
                        size: 20,
                        color: Color.fromARGB(255, 0, 2, 118),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.home_outlined,
                      color: Color.fromARGB(255, 133, 133, 148),
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'Início',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 133, 148),
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.directions_car_outlined,
                      color: Color.fromARGB(255, 133, 133, 148),
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'Veículo',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 133, 148),
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.engineering_outlined,
                      color: Color.fromARGB(255, 133, 133, 148),
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'Serviços',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 133, 148),
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.pin_drop_outlined,
                      color: Color.fromARGB(255, 133, 133, 148),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapScreen(
                                  latitude: -18.5122, // Latitude de Minas Gerais (exemplo)
                                  longitude: -44.5550,
                                )),
                      );
                    },
                  ),
                  const Text(
                    'Mapa',
                    style: TextStyle(
                      color: Color.fromARGB(255, 133, 133, 148),
                      fontFamily: 'Comfortaa',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
