import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Aluno {
  String nome;
  String matricula;
  List<double> notas = [];

  Aluno({required this.nome, required this.matricula});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CadastroAlunoScreen(),
    );
  }
}

class CadastroAlunoScreen extends StatefulWidget {
  @override
  _CadastroAlunoScreenState createState() => _CadastroAlunoScreenState();
}

class _CadastroAlunoScreenState extends State<CadastroAlunoScreen> {
  final _nomeController = TextEditingController();
  final _matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro do Aluno")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: _matriculaController,
              decoration: InputDecoration(labelText: "Matrícula"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Avançar"),
              onPressed: () {
                if (_nomeController.text.isNotEmpty &&
                    _matriculaController.text.isNotEmpty) {
                  final aluno = Aluno(
                    nome: _nomeController.text,
                    matricula: _matriculaController.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LancarNotasScreen(aluno: aluno),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

class LancarNotasScreen extends StatefulWidget {
  final Aluno aluno;

  LancarNotasScreen({required this.aluno});

  @override
  _LancarNotasScreenState createState() => _LancarNotasScreenState();
}

class _LancarNotasScreenState extends State<LancarNotasScreen> {
  final _notaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lançar Notas")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _notaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Digite a nota"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Adicionar Nota"),
              onPressed: () {
                if (_notaController.text.isNotEmpty) {
                  setState(() {
                    widget.aluno.notas.add(double.parse(_notaController.text));
                    _notaController.clear();
                  });
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Ver Resumo"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResumoAlunoScreen(aluno: widget.aluno),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ResumoAlunoScreen extends StatelessWidget {
  final Aluno aluno;

  ResumoAlunoScreen({required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Resumo do Aluno")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nome: ${aluno.nome}", style: TextStyle(fontSize: 18)),
            Text("Matrícula: ${aluno.matricula}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text("Notas:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: aluno.notas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.star, color: Colors.blue),
                    title: Text("Nota ${index + 1}: ${aluno.notas[index]}"),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
