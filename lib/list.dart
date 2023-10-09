import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sprint3/domain/models/CarData.dart';
import 'package:sprint3/map.dart';

class ListCarsScreen extends StatefulWidget {
  const ListCarsScreen({Key? key}) : super(key: key);

  @override
  State<ListCarsScreen> createState() => _ListCarsScreenState();
}

String removerCaracteresEspeciais(String input) {
  final regex = RegExp(r'[^\w\s]+');
  return input.replaceAll(regex, '');
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
      Uri.parse(
          'https://fordfuel.rj.r.appspot.com/v2/fordfuel/abastecimentos-detalhados'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData =
          json.decode(const Utf8Decoder().convert(response.bodyBytes));
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
                            const Text(
                              "Cidade: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.enderecoFormatado,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    final double latitude =
                                        double.parse(car.latitude);
                                    final double longitude =
                                        double.parse(car.longitude);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MapScreen(
                                          latitude: latitude,
                                          longitude: longitude,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text('Visualizar no mapa'),
                                ),
                              ],
                            ),
                          ],
                        ),
                         Row(
                          children: [
                            const Icon(Icons.pin_drop_outlined, size: 16),
                            const SizedBox(width: 8),
                            const Text(
                              "Rua: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.rua,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.pin_drop_outlined, size: 16),
                            const SizedBox(width: 8),
                            const Text(
                              "Bairro: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.bairro,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.map_outlined, size: 16),
                            const SizedBox(width: 8),
                            const Text(
                              "Cep: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.cep,
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
                            const Text(
                              'Data e Hora: ',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              DateFormat('dd/MM/yyyy HH:mm').format(
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
                            const Text(
                              "Combustível: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.nomeTipoCombustivel,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.engineering_outlined, size: 16),
                            const SizedBox(width: 8),
                            const Text(
                              "Nome do Posto: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.nomePosto,
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
                            const Text(
                              "Combustível: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.nomeTipoCombustivel,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.engineering_outlined, size: 16),
                            const SizedBox(width: 8),
                            const Text(
                              "Qualidade: ",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Comfortaa',
                              ),
                            ),
                            Text(
                              car.qualidade,
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
