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
  String temp = '';
  String humidity = '';
  String windSpeed = '';
  TextEditingController cidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void buscaLocalizacao(String cidade) async {
    String url = 'https://geocoding-api.open-meteo.com/v1/search?name=$cidade';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        var lat = jsonBody['results'][0]['latitude'];
        var lon = jsonBody['results'][0]['longitude'];
        buscaTemperatura(lat, lon);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Ocorreu um erro na requisição: $e');
    }
  }

  Future<void> buscaTemperatura(double lat, double lon) async {
    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=relative_humidity_2m';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);

        temp = jsonBody['current_weather']['temperature'].toString();
        humidity = jsonBody['hourly']['relative_humidity_2m'][0].toString();
        windSpeed = jsonBody['current_weather']['windspeed'].toString();
        print('$temp-$humidity-$windSpeed');
      } else {
        print('Erro ao acessar a API. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Ocorreu um erro na requisição: $e');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Geolocalização e Clima",
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: cidadeController,
              decoration: InputDecoration(labelText: 'Cidade:'),
            ),
            ElevatedButton(
              onPressed: () {
                buscaLocalizacao(cidadeController.text);
              },
              child: Text('Ver Clima'),
            ),
            const SizedBox(height: 20),
            Text('Dados do Clima'),
            Text('Temperatura: $temp °C'),
            Text('Umidade: $humidity %'),
            Text('Velocidade do Vento: $windSpeed km/h'),
          ],
        ),
      ),
    );
  }
}
