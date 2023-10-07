import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprint3/domain/models/CarData.dart';

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
    final response = await http.get(
      Uri.parse('http://localhost:8080/v2/fordfuel/abastecimentos-detalhados'),
      // headers: {"Accept-Charset": "UTF-8"},
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print(responseData);
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
        backgroundColor: const Color(0xFFbcdbf1),
        centerTitle: true,
        title: const Text('Histórico'),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontFamily: 'Comfortaa',
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Histórico de Abastecimento',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 20, 130),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 12.0),
            child: const Text(
              'Acesse todas as informações sobre os históricos de abastecimento do seu veículo',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 0, 20, 130),
                fontFamily: 'Comfortaa',
              ),
              textAlign: TextAlign.start,
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
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.house, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              car.enderecoFormatado,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.date_range, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(car.abastecimentoDate)),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.local_gas_station, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              car.nomeTipoCombustivel,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
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
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: ListCarsScreen(),
  ));
}
