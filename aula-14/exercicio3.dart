import 'dart:convert';
import 'dart:math';
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
  TextEditingController cardController = TextEditingController();
  String dica = '';
  String cardImage = '';
  String cardName = '';
  int acertos = 0;
  int counter = 1;
  int tentativas = 0;

  @override
  void initState() {
    super.initState();
    cardSearch();
  }

  void cardSearch() async {
    //String url = 'https://db.ygoprodeck.com/api/v7/cardinfo.php?name=Decode Talker';
    String url = 'https://db.ygoprodeck.com/api/v7/randomcard.php';

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonBody = json.decode(response.body);
        cardImage = jsonBody['data'][0]['card_images'][0]['image_url_cropped'];
        cardName = jsonBody['data'][0]['name'];
        Random random = Random();
        int tamanhoSubstring = cardName.length ~/ 2;
        int inicio = random.nextInt(cardName.length - tamanhoSubstring);

        dica = cardName.substring(inicio, inicio + tamanhoSubstring);

        setState(() {});
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Ocorreu um erro na requisição: $e');
    }
  }

  void checkCard(String cardChoice) {
    cardName = cardName.replaceAll(" ", '');
    cardName = cardName.toLowerCase();

    cardChoice = cardChoice.replaceAll(" ", '');
    cardChoice = cardChoice.toLowerCase();

    if (cardChoice == cardName) {
      cardSearch();
      acertos++;
      counter = 1;
    } else if (counter == 3) {
      counter = 1;
      cardSearch();
    } else {
      print('errou');
      counter++;
    }
    tentativas++;
    setState(() {
      cardController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Guess the Card!!!", textAlign: TextAlign.center),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Acertos: $acertos', style: TextStyle(fontSize: 15)),
                Text(
                  'Dica: ${dica == '' ? '' : dica}',
                  style: TextStyle(fontSize: 15),
                ),
                Text('Tentativas: $tentativas', style: TextStyle(fontSize: 15)),
              ],
            ),
            cardImage == ''
                ? SizedBox.shrink()
                : SizedBox(
                    height: 200,
                    child: Image.network(cardImage, fit: BoxFit.scaleDown),
                  ),
            SizedBox(height: 20),
            TextField(
              controller: cardController,
              decoration: InputDecoration(labelText: 'Card Name:'),
            ),
            ElevatedButton(
              onPressed: () {
                checkCard(cardController.text);
              },
              child: Text('Responder'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
