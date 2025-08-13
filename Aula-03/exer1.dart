import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CorujaPagina()),
  );
}

class PrimeiraPagina extends StatelessWidget {
  const PrimeiraPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Aves'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // código para ir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CorujaPagina(),
                  ),
                );
              },
              child: const Text('Coruja Buraqueira'),
            ),
            ElevatedButton(
              onPressed: () {
                // código para ir
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RolinhaPagina(),
                  ),
                );
              },
              child: const Text('Rolinha do Planalto'),
            ),
          ],
        ),
      ),
    );
  }
}

class RolinhaPagina extends StatelessWidget {
  const RolinhaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Rolinha do Planalto'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.lightBlue[50],
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Image.network(
                'https://static.wixstatic.com/media/6d1e48_1789d9211df04b428974e987bcb79662~mv2.png/v1/fill/w_280,h_280,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/Design%20sem%20nome%20(22).png',
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // código para voltar
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CorujaPagina(),
                  ),
                );
              },
              child: const Text('Coruja Buraqueira'),
            ),
          ],
        ),
      ),
    );
  }
}

class CorujaPagina extends StatelessWidget {
  const CorujaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[400],
      appBar: AppBar(
        title: Text('Coruja Buraqueira'),
        backgroundColor: Colors.lightGreen[800],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.lightBlue[50],
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              child: Image.network(
                'https://agron.com.br/wp-content/uploads/2025/05/Como-a-coruja-buraqueira-vive-em-grupo-2.webp',
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RolinhaPagina(),
                  ),
                );
              },
              child: const Text('Rolinha do Planalto'),
            ),
          ],
        ),
      ),
    );
  }
}
