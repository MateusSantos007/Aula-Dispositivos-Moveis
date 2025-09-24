import 'package:flutter/material.dart';
import 'package:flutter_application_1/pergunta.dart';

void main() {
  runApp(const Perguntas());
}

class Perguntas extends StatefulWidget {
  const Perguntas({super.key});

  @override
  State<Perguntas> createState() => _PerguntasState();
}

class _PerguntasState extends State<Perguntas> {
  List<Widget> resultado = [];

  List perguntas = [
    Pergunta(p: 'Qual é a capital da França?', r: 'Berlim', c: false),
    Pergunta(
      p: 'Quem escreveu "Dom Quixote"?',
      r: 'William Shakespeare',
      c: false,
    ),
    Pergunta(
      p: 'Qual é o maior planeta do sistema solar?',
      r: 'Saturno',
      c: false,
    ),
    Pergunta(p: 'Em que ano ocorreu a Revolução Francesa?', r: '1789', c: true),
    Pergunta(p: 'Quem pintou a Mona Lisa?', r: 'Leonardo da Vinci', c: true),
    Pergunta(
      p: "Qual é o elemento químico representado pelo símbolo 'O'?",
      r: 'Ouro',
      c: false,
    ),
    Pergunta(
      p: 'Qual é o rio mais longo do mundo?',
      r: 'Rio Amazonas',
      c: false,
    ),
    Pergunta(
      p: 'Quem foi o primeiro presidente dos Estados Unidos?',
      r: 'Abraham Lincoln',
      c: false,
    ),
    Pergunta(p: 'Qual é o país mais populoso do mundo?', r: 'China', c: true),
    Pergunta(p: 'Qual é a fórmula química da água?', r: 'H2O', c: true),
  ];

  var numeroPergunta = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: Text(
                    perguntas[numeroPergunta].pergunta,
                    style: TextStyle(fontFamily: 'Quicksand', fontSize: 32),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  perguntas[numeroPergunta].resposta,
                  style: TextStyle(fontFamily: 'Quicksand', fontSize: 28),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    if (numeroPergunta < perguntas.length - 1) {
                      if (perguntas[numeroPergunta].correta == true) {
                        resultado.add(
                          const Icon(Icons.check, color: Colors.green),
                        );
                      } else {
                        resultado.add(
                          const Icon(Icons.close, color: Colors.red),
                        );
                      }
                      numeroPergunta++;
                    }
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  minimumSize: Size(200, 60),
                ),
                child: const Text(
                  'SIM',
                  style: TextStyle(fontFamily: 'Quicksand', fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (numeroPergunta < perguntas.length - 1) {
                        if (perguntas[numeroPergunta].correta == false) {
                          resultado.add(
                            const Icon(Icons.check, color: Colors.green),
                          );
                        } else {
                          resultado.add(
                            const Icon(Icons.close, color: Colors.red),
                          );
                        }
                        numeroPergunta++;
                      }
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(200, 60),
                  ),
                  child: const Text(
                    'NÃO',
                    style: TextStyle(fontFamily: 'Quicksand', fontSize: 22),
                  ),
                ),
              ),
              Row(children: resultado),
            ],
          ),
        ),
      ),
    );
  }
}
