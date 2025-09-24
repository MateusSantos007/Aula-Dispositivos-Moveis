import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treinar Tabuada',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TabuadaPage(),
    );
  }
}

class TabuadaPage extends StatefulWidget {
  @override
  _TabuadaPageState createState() => _TabuadaPageState();
}

class _TabuadaPageState extends State<TabuadaPage> {
  int _tabuadaAtual = 1;
  int _resultadoCorreto = 0;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTabuada();
  }

  // Carregar o estado atual da tabuada
  _loadTabuada() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _tabuadaAtual =
          prefs.getInt('tabuadaAtual') ?? 1; // Começa com a tabuada 1
    });
  }

  // Salvar o estado da tabuada
  _saveTabuada() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('tabuadaAtual', _tabuadaAtual);
  }

  // Verificar a resposta e progredir para a próxima tabuada se estiver correta
  _verificarResposta() {
    int resposta = int.tryParse(_controller.text) ?? -1;
    int resultado = _tabuadaAtual * _resultadoCorreto;

    if (resposta == resultado) {
      setState(() {
        _resultadoCorreto++;
      });
      _controller.clear();

      // Se acertou todas as respostas da tabuada atual, passa para a próxima
      if (_resultadoCorreto > 10) {
        setState(() {
          _tabuadaAtual++;
          _resultadoCorreto = 1;
        });
        _saveTabuada();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Resposta errada! Tente novamente.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Gerar a conta da tabuada
  _gerarConta() {
    return 'Quanto é $_tabuadaAtual x $_resultadoCorreto?';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(_gerarConta(), style: TextStyle(fontSize: 28)),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Sua resposta'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _verificarResposta,
              child: Text('Verificar Resposta'),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
