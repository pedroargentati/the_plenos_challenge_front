import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        await http.get(Uri.parse('http://localhost:8080/api/address'));
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
        backgroundColor: const Color(0xFFbcdbf1),
        centerTitle: true,
        title: const Text('Histórico'),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              'Histórico de serviços',
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
              'Acesse todas as informações sobre os serviços, revisões e recalls realizados no seu Ford',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 0, 20, 130),
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
                            const Icon(Icons.local_gas_station, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              car.enderecoFormatado,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.date_range, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              DateFormat('dd/MM/yyyy').format(
                                  DateTime.parse(car.abastecimentoDate)),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            const Icon(Icons.local_gas_station, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              car.nomeTipoCombustivel,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     const Icon(Icons.location_on, size: 16),
                        //     const SizedBox(width: 4),
                        //     Text(
                        //       car.abastecimentoDate,
                        //       style: const TextStyle(fontSize: 14),
                        //     ),
                        //   ],
                        // ),
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

class CarData {
  final String enderecoFormatado;
  final String abastecimentoDate;
  final String nomeTipoCombustivel;
  //final String qualidade;

  CarData(
      this.enderecoFormatado, this.abastecimentoDate, this.nomeTipoCombustivel);

  factory CarData.fromJson(Map<String, dynamic> json) {
    return CarData(json['enderecoFormatado'], json['abastecimentoDate'],
        json['nomeTipoCombustivel']);
  }
}

void main() {
  runApp(const MaterialApp(
    home: ListCarsScreen(),
  ));
}
