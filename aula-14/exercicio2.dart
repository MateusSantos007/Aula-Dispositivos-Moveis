import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  String definicao = '';

  @override
  void initState() {
    super.initState();
  }

  void buscaSignificado(String word) async {
    String url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        definicao = jsonBody[0]['meanings'][0]['definitions'][0]['definition'];
        setState(() {});
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Ocorreu um erro na requisição: $e');
      definicao = '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Dicionario", textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(labelText: 'Word:'),
            ),
            ElevatedButton(
              onPressed: () {
                buscaSignificado(controller.text);
              },
              child: Text('Ver Definição'),
            ),
            const SizedBox(height: 20),
            definicao == ''
                ? Text('Nenhuma definição')
                : Text('Definição: $definicao'),
          ],
        ),
      ),
    );
  }
}
