import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<String> buscaPost() async {
  
  DateTime data = DateTime.now();
  
  if(data.weekday == 7){
    data = data.subtract(const Duration(days: 2));
  }else if(data.weekday == 1){
    data = data.subtract(const Duration(days: 3));
  }else{
    data = data.subtract(const Duration(days: 1));
  }
  
  var url = Uri.https('olinda.bcb.gov.br',
'/olinda/servico/PTAX/versao/v1/odata/CotacaoDolarDia(dataCotacao=@dataCotacao)',
{'@dataCotacao': '\'${data.month}-${data.day}-${data.year}\'',
 '\$top':'100',
  '\$format':'json',
  '\$select':'cotacaoCompra'}
    );

  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonBody = json.decode(response.body);

      var cotacao = jsonBody['value'][0]['cotacaoCompra'].toString();
      return cotacao;
    } else {
      return 'Erro ao acessar a API. Status Code: ${response.statusCode}';
    }
  } catch (e) {
    return 'Ocorreu um erro na requisição: $e';
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: FutureBuilder<String>(
            future: buscaPost(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Text(snapshot.data != null ? 'Cotacao: ${snapshot.data}' : 'Vazio');
              }
              
            },
          ),
        ),
      ),
    );
  }
}
