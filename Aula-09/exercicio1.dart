import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const Color fundo = Color(0xFF1E164B);
const Color selecionado = Color.fromARGB(255, 45, 11, 237);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double alturaPessoa = 1.50;
  int peso = 65;
  double resultado = 0.0;
  bool masc = true;
  bool fem = false;

  void mudarGenero(){
    setState(() {
      masc = !masc;
      fem = !fem;
    });
  }

  Color setColor(bool escolhido){
    return escolhido ? selecionado : fundo;
  }

  void calcularIMC(int peso, double altura) {
    setState(() {
      resultado = peso / pow(altura, 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('IMC')),
        body: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                'https://cdn.eso.org/images/wallpaper3/b07.jpg',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: mudarGenero,
                        child: Caixa(
                          cor: setColor(masc),
                          filho: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.male, size: 80),
                              SizedBox(height: 15),
                              Text(
                                'MASC',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: mudarGenero,
                        child: Caixa(
                          cor: setColor(fem),
                          filho: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.female, size: 80),
                              SizedBox(height: 15),
                              Text(
                                'FEM',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Caixa(
                  cor: fundo,
                  filho: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Altura:',
                        style: TextStyle(color: Colors.white54, fontSize: 28),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${alturaPessoa.toStringAsFixed(2).replaceAll('.', ',')} cm',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          Slider(
                            value: alturaPessoa,
                            min: 1.00,
                            max: 2.00,
                            onChanged: (double value) {
                              setState(() {
                                alturaPessoa = value;
                                calcularIMC(peso, alturaPessoa);
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Caixa(
                        cor: fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Peso:',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 28,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$peso Kg',
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          peso++;
                                          calcularIMC(peso, alturaPessoa);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        size: 50,
                                        color: Colors.white24,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          peso--;
                                          calcularIMC(peso, alturaPessoa);
                                        });
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                        size: 50,
                                        color: Colors.white24,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Caixa(
                        cor: fundo,
                        filho: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Resultado:',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              resultado.toStringAsFixed(2),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Caixa extends StatelessWidget {
  final Color cor;
  final Widget? filho;

  @override
  const Caixa({super.key, required this.cor, this.filho});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: cor,
      ),
      child: filho,
    );
  }
}
