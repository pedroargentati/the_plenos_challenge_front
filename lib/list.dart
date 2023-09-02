import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:sprint3/main.dart';

class ListCarsScreen extends StatefulWidget {
  const ListCarsScreen({Key? key}) : super(key: key);

  @override
  State<ListCarsScreen> createState() => _ListCarsScreenState();
}

class _ListCarsScreenState extends State<ListCarsScreen> {
  List<CarData> carList = [];

  @override
  void initState() {
    super.initState();
    fetchCarData();
  }

  Future<void> fetchCarData() async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/api/combustivel'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final List<CarData> cars =
          responseData.map((data) => CarData.fromJson(data)).toList();

      setState(() {
        carList = cars;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text('Lista de Dados de Carros'),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Center(
              child: Text(
                
                'Bem vindo(a) ao seu histórico de postos de gasolina, aqui você encontra os locais onde você abasteceu',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center, // Centralizar o texto
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: carList.length,
              itemBuilder: (BuildContext context, int index) {
                final car = carList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_gas_station, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              car.nomePosto,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.location_on, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              car.endereco,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(DateTime.parse(car.data)),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.local_gas_station, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              car.combustivel,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.high_quality, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              car.qualidade,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200], // Fundo cinza
        height: 60, // Altura do footer
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CarScreen()),
                    );
              },
            ),
            IconButton(
              icon: const Icon(Icons.directions_car),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.explore),
              onPressed: () {},
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

class CarData {
  final String nomePosto;
  final String endereco;
  final String data;
  final String combustivel;
  final String qualidade;

  CarData(this.nomePosto, this.endereco, this.data, this.combustivel, this.qualidade);

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(
      json['nomePosto'],
      json['endereco'],
      json['data'],
      json['tipo'],
      json['qualidade']
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ListCarsScreen(),
  ));
}
