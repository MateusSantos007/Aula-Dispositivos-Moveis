import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DataNascimento(),
    );
  }
}

// Tela 1: Entrada da data de nascimento
class DataNascimento extends StatefulWidget {
  const DataNascimento({super.key});

  @override
  State<DataNascimento> createState() => _DataNascimentoState();
}

class _DataNascimentoState extends State<DataNascimento> {
  DateTime? date;

  Future<void> escolherDate(BuildContext context) async {
    final DateTime? _date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (_date != null) {
      setState(() {
        date = _date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Informe sua data de nascimento")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date == null
                  ? "Nenhuma data selecionada"
                  : "Data: ${date!.day}/${date!.month}/${date!.year}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => escolherDate(context),
              child: const Text("Selecionar Data"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: date == null
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Idade(dataNascimento: date!),
                        ),
                      );
                    },
              child: const Text("Calcular Idade"),
            ),
          ],
        ),
      ),
    );
  }
}

class Idade extends StatelessWidget {
  final DateTime dataNascimento;

  const Idade({super.key, required this.dataNascimento});

  int _calcularIdade(DateTime data) {
    int idade = DateTime.now().year - data.year;

    if (DateTime.now().month < data.month ||
        (DateTime.now().month == data.month && DateTime.now().day < data.day)) {
      idade--;
    }
    return idade;
  }

  @override
  Widget build(BuildContext context) {
    final idade = _calcularIdade(dataNascimento);

    return Scaffold(
      appBar: AppBar(title: const Text("Sua Idade")),
      body: Center(
        child: Text(
          "Você tem $idade anos",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
