import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Círculo - Cálculos',
      debugShowCheckedModeBanner: false,
      home: CircleTabs(),
    );
  }
}

class CircleTabs extends StatefulWidget {
  const CircleTabs({super.key});

  @override
  State<CircleTabs> createState() => _CircleTabsState();
}

class _CircleTabsState extends State<CircleTabs> {
  final TextEditingController _controller = TextEditingController();
  double? raio;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Círculo"),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Raio"),
              Tab(text: "Diâmetro"),
              Tab(text: "Circunferência"),
              Tab(text: "Área"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Digite o raio",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        raio = double.tryParse(
                          _controller.text.replaceAll(',', '.'),
                        );
                      });
                    },
                    child: const Text("Calcular"),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                raio == null
                    ? "Digite o raio na primeira aba"
                    : "Diâmetro: ${(2 * raio!).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 22),
              ),
            ),
            Center(
              child: Text(
                raio == null
                    ? "Digite o raio na primeira aba"
                    : "Circunferência: ${(2 * pi * raio!).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 22),
              ),
            ),
            Center(
              child: Text(
                raio == null
                    ? "Digite o raio na primeira aba"
                    : "Área: ${(pi * pow(raio!, 2)).toStringAsFixed(2)}",
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
