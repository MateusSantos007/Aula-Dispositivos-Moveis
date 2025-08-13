import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: PrimeiraPagina()),
  );
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Sobre Mim'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('Mateus'),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // código para ir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FilmesPagina(),
                  ),
                );
              },
              child: const Text('Filmes'),
            ),
            ElevatedButton(
              onPressed: () {
                // código para ir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LivrosPagina(),
                  ),
                );
              },
              child: const Text('Livros'),
            ),
          ],
        ),
      ),
    );
  }
}

class LivrosPagina extends StatelessWidget {
  const LivrosPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Meus Livros Favoritos'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('1 - Dom Quixote'),
            Text('2 - 1984'),
            Text('3 - O hobbit'),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // código para voltar
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrimeiraPagina(),
                  ),
                );
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

class FilmesPagina extends StatelessWidget {
  const FilmesPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Meus Filmes Favoritos'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text('1 - O Senhor dos Anéis'),
            Text('2 - Star Wars'),
            Text('3 - Matrix'),
            Text('4 - Interestelar'),
            Text('5 - Vingadores'),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PrimeiraPagina(),
                  ),
                );
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}
