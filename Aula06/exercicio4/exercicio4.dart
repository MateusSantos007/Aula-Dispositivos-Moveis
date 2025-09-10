import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();

    player = AudioPlayer();
  }

  var itens = ['images/pedra.jpg', "images/papel.jpg", 'images/tesoura.jpg'];

  var random = 0;

  void jogada() {
    random = Random().nextInt(3);
  }

  var index = 0;
  var resultado = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      width: 200,
                      child: Image.asset(itens[index]),
                    ),
                    SizedBox(
                      height: 200,
                      width: 180,
                      child: Image.asset(itens[random]),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () {
                    setState(() {
                      if (index == itens.length - 1) {
                        index = 0;
                      } else {
                        index++;
                      }
                      resultado = '';
                    });
                  },
                  child: Text("Próximo", style: TextStyle(fontSize: 20)),
                ),
              ),
              Container(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.lightBlue),
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  onPressed: () async {
                    setState(() {
                      jogada();
                      if (index == 0) {
                        if (random == 0) {
                          resultado = "Empate";
                        }
                        if (random == 1) {
                          resultado = "Derrota";
                        }
                        if (random == 2) {
                          resultado = "Vitoria";
                        }
                      }
                      if (index == 1) {
                        if (random == 0) {
                          resultado = "Vitoria";
                        }
                        if (random == 1) {
                          resultado = "Empate";
                        }
                        if (random == 2) {
                          resultado = "Derrota";
                        }
                      }
                      if (index == 2) {
                        if (random == 0) {
                          resultado = "Derrota";
                        }
                        if (random == 1) {
                          resultado = "Vitoria";
                        }
                        if (random == 2) {
                          resultado = "Empate";
                        }
                      }
                    });
                    if (resultado == 'Vitoria') {
                      await player.play(DeviceFileSource('audio/vitoria.mp3'));
                    }
                    if (resultado == "Derrota") {
                      await player.play(DeviceFileSource('audio/derrota.mp3'));
                    }
                    if (resultado == 'Empate') {
                      await player.play(DeviceFileSource('audio/empate.mp3'));
                    }
                  },
                  child: Text("Escolher"),
                ),
              ),
              Text(resultado),
            ],
          ),
        ),
      ),
    );
  }
}
