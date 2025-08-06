class Aluno {
  String nome;
  String matricula;
  List<double> notas;

  Aluno(this.nome, this.matricula) : notas = [];

  void lancanota(double x) {
    notas.add(x);
  }
}

void main() {
  Aluno('Fulano de Tal', '123456');
}
