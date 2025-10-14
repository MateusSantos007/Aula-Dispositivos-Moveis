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
  double peso = 20.0;
  int idade = 1;
  double resultado = 0;
  bool dog = true;
  bool cat = false;

  void mudarAnimal(){
    setState(() {
      dog = !dog;
      cat = !cat;
      calcularIdade(idade,peso);
    });
  }

  Color setColor(bool escolhido){
    return escolhido ? selecionado : fundo;
  }

  void calcularIdade(int idade, double peso) {
    setState(() {
      if(idade == 1){
        resultado = 15;
      }

      if(cat && idade != 1){
        resultado = 24 + (4 * (idade - 2));
      }
      
      if(dog && idade != 1){
        if(peso <= 9.07){
          resultado = 24 + (4 * (idade - 2));
        }
        if(peso > 9.07 && peso <= 22.7){
          resultado = (24 + ((idade - 2) ~/ 2) * 9 + ((idade - 2) % 2) * 4);
          if(idade > 6 && idade % 2 == 1){
            resultado += 1;
          }
        }
        if(peso > 22.7 && peso <= 40.8){
          resultado = 24 + 5 * (idade - 2);
          if(idade == 9 || idade == 10 || idade == 14 || idade == 16 || idade == 19){
            resultado += 2;
          }else{
            if(idade != 2) resultado += 1;
          }
        }
        if(peso > 40.8){
          resultado = 24 + 7 * (idade - 2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Idade Fisiológica')),
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
                        onTap: mudarAnimal,
                        child: Caixa(
                          cor: setColor(dog),
                          filho: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pets, size: 80),
                              SizedBox(height: 15),
                              Text(
                                'CACHORRO',
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
                        onTap: mudarAnimal,
                        child: Caixa(
                          cor: setColor(cat),
                          filho: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.pets, size: 80),
                              SizedBox(height: 15),
                              Text(
                                'GATO',
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
                        'Peso:',
                        style: TextStyle(color: Colors.white54, fontSize: 28),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${peso.toStringAsFixed(2).replaceAll('.', ',')} Kg',
                            style: TextStyle(fontSize: 22, color: Colors.white),
                          ),
                          Slider(
                            value: peso,
                            min: 1.00,
                            max: 50.00,
                            onChanged: (double value) {
                              setState(() {
                                peso = value;
                                calcularIdade(idade, peso);
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
                              'Idade:',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 28,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$idade',
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
                                          if(idade != 20) idade++;
                                          calcularIdade(idade, peso);
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
                                          if(idade != 1) idade--;
                                          calcularIdade(idade, peso);
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
                              resultado.toStringAsFixed(0),
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
