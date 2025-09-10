import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var itens = [
    'https://t3.ftcdn.net/jpg/01/23/14/80/360_F_123148069_wkgBuIsIROXbyLVWq7YNhJWPcxlamPeZ.jpg',
    "https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/KAcAAOSwTw5bnTbW/\$_57.JPG",
    'https://t4.ftcdn.net/jpg/02/55/26/63/360_F_255266320_plc5wjJmfpqqKLh0WnJyLmjc6jFE9vfo.jpg',
  ];

  var random = 0;
  var escolha = Random().nextInt(5) + 1;
  var vitoria = 1;

  void jogada() {
    if (vitoria <= 5) {
      if (vitoria != escolha) {
        if (index == 0) {
          random = 1;
        }
        if (index == 1) {
          random = 2;
        }
        if (index == 2) {
          random = 0;
        }
      } else {
        if (index == 0) {
          random = 2;
        }
        if (index == 1) {
          random = 0;
        }
        if (index == 2) {
          random = 1;
        }
      }
      vitoria++;
    }
    if (vitoria > 5) {
      escolha = Random().nextInt(5) + 1;
      vitoria = 0;
    }
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
                      child: Image.network(itens[index]),
                    ),
                    SizedBox(
                      height: 200,
                      width: 180,
                      child: Image.network(itens[random]),
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
                  onPressed: () {
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
