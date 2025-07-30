void main() {
  var hoje = DateTime.now().day;
  var inicio = DateTime(2025, 7, 1);

  int diaMes = 1;
  String semana = '';

  print('|D |S| T| Q| Q| S| S|');

  for (int i = 1; i <= 7; i++) {
    if (i >= inicio.weekday) {
      semana += '$i |';
      diaMes++;
    } else {
      semana += ' |';
    }
  }

  print(semana);
}
