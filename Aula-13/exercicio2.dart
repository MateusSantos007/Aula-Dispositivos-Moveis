import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  String latitude = 'Carregando Latitude';
  String longitude = 'Carregando Longitude';
  String temperatura = 'Carregando Temperatura';
  String umidade = 'Carregando Umidade';
  String vento = 'Carregando Velocidade do Vento';

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> buscaPost() async {
    double lat = double.parse(latitude);
    double lon = double.parse(longitude);

    String url =
        'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true&hourly=relative_humidity_2m';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);

        String temp = jsonBody['current_weather']['temperature'].toString();
        String humidity = jsonBody['hourly']['relative_humidity_2m'][0]
            .toString();
        String windSpeed = jsonBody['current_weather']['windspeed'].toString();

        setState(() {
          temperatura = temp;
          umidade = humidity;
          vento = windSpeed;
        });
      } else {
        print('Erro ao acessar a API. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Ocorreu um erro na requisição: $e');
    }
  }

  Future<void> _initializeLocation() async {
    try {
      await Posicao.instance._init();

      setState(() {
        latitude = Posicao.instance.latitude;
        longitude = Posicao.instance.longitude;
        buscaPost();
      });
    } catch (e) {
      setState(() {
        latitude = 'Erro ao obter latitude';
        longitude = 'Erro ao obter longitude';
      });
    }
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
            const Text('Dados de Localização e Clima'),
            Text('Latitude: $latitude'),
            Text('Longitude: $longitude'),
            const SizedBox(height: 20),
            Text('Temperatura: $temperatura °C'),
            Text('Umidade: $umidade %'),
            Text('Velocidade do Vento: $vento km/h'),
          ],
        ),
      ),
    );
  }
}

class Posicao {
  static final Posicao instance = Posicao._init();
  late String latitude;
  late String longitude;

  Posicao._init();

  // Função que obtém a localização atual do dispositivo
  Future<void> _init() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Testa se o serviço de localização está ativado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Serviços de localização estão desativados.');
    }

    // Verifica a permissão de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Permissão de localização negada');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Permissões de localização permanentemente negadas. Não podemos solicitar permissões.',
      );
    }

    // Obtém a localização atual
    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude.toString();
    longitude = position.longitude.toString();
  }
}
