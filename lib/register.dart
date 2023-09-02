import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sprint3/list.dart';
import 'package:sprint3/main.dart';

class RegisterCombustivelScreen extends StatefulWidget {
  const RegisterCombustivelScreen({Key? key}) : super(key: key);

  @override
  State<RegisterCombustivelScreen> createState() =>
      _RegisterCombustivelScreenState();
}

class _RegisterCombustivelScreenState extends State<RegisterCombustivelScreen> {
  final nomePostoController = TextEditingController();
  final enderecoController = TextEditingController();
  final dataController = TextEditingController();
  final tipoController = TextEditingController();
  final qualidadeController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Future<void> registerCombustivel() async {
    final Map<String, dynamic> formData = {
      "nomePosto": nomePostoController.text,
      "endereco": enderecoController.text,
      "data": selectedDate.millisecondsSinceEpoch,
      "tipo": tipoController.text,
      "qualidade": qualidadeController.text
    };

    final response = await http.post(
      Uri.parse("http://localhost:8080/api/register/combustivel"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(formData),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Cadastro realizado"),
            content: const Text("O combustível foi cadastrado com sucesso."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListCarsScreen()),
                  );
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Erro ao cadastrar"),
            content: const Text("Não foi possível cadastrar o combustível."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dataController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
        title: const Text('Cadastrar Combustível'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nomePostoController,
              decoration: const InputDecoration(labelText: 'Nome do Posto'),
            ),
            TextField(
              controller: enderecoController,
              decoration: const InputDecoration(labelText: 'Endereço'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: dataController,
                  decoration: const InputDecoration(labelText: 'Data'),
                ),
              ),
            ),
            TextField(
              controller: tipoController,
              decoration: const InputDecoration(labelText: 'Tipo'),
            ),
            TextField(
              controller: qualidadeController,
              decoration: const InputDecoration(labelText: 'Qualidade'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black)),
              onPressed: registerCombustivel,
              child: const Text('Cadastrar'),
            )
          ],
        ),
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
                  MaterialPageRoute(builder: (context) => const CarScreen()),
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
