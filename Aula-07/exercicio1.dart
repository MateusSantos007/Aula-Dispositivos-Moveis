import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cálculo da Área',
      debugShowCheckedModeBanner: false,
      home: const Raio(),
    );
  }
}

class Raio extends StatefulWidget {
  const Raio({super.key});

  @override
  State<Raio> createState() => _RaioState();
}

class _RaioState extends State<Raio> {
  final TextEditingController _controlador = TextEditingController();

  void _calcularArea() {
    if (_controlador.text.isEmpty) return;

    final raio = double.parse(_controlador.text.replaceAll(',', '.'));
    final area = pi * raio * raio;
    final resultado = area.toStringAsFixed(2);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Area(resultado: resultado),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calcular área do círculo")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _controlador,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Digite o raio",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularArea,
                child: const Text("Calcular área"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Area extends StatelessWidget {
  final String resultado;

  const Area({super.key, required this.resultado});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Resultado")),
      body: Center(
        child: Text(
          'Área do círculo: $resultado',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
