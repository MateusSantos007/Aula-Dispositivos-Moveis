void main() {
  var diaAtual = DateTime.now();
  var inicio = DateTime(2025,diaAtual.month,1);
  
  StringBuffer calendario =  StringBuffer('');
  calendario.writeln('| D  | S  | T  | Q  | Q  | S  | S  |');
  int semana = inicio.weekday;
  int aux = 7;
  
  while(true){
    if(aux == 7){
      aux = 0;
    }else{
      aux++;
    }
    
    calendario.write('|    ');
    
    if(aux  == semana - 1 ){
      break;
    }
  }
    
  for(int dias = 1; dias <= diaAtual.day; dias++){
    if(semana == 6){
      if(dias < 10){
        calendario.writeln('| $dias  |');
      }else{
        calendario.writeln('| $dias |');
      }
    }else{
      if(dias < 10){
        calendario.write('| $dias  ');
      }else{
        calendario.write('| $dias ');
      }
    }
    
    if(semana == 7){
      semana = 1;
    }else{
      semana++; 
    }
  }
  
  print(calendario);
}
