void main() {
  int mesInformado = 10;
  var mesAtual = DateTime.now().month;

  if (mesAtual < mesInformado) {
    print('O mês atual é menor que o mês informado');
  } else if (mesAtual > mesInformado) {
    print('O mês atual é maior que o mes informado');
  } else {
    print('O mês atual é igual ao mês informado');
  }
}
