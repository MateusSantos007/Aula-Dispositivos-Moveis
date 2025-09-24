class Pergunta {
  String pergunta = '';
  String resposta = '';
  bool correta = false;

  Pergunta({required String p, required String r, required bool c}) {
    pergunta = p;
    resposta = r;
    correta = c;
  }
}
