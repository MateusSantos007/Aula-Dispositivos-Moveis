import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var n1 = "";
  var n2 = "";
  var bsum = false;
  var sum = 0;
  var visor = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  visor == ""
                      ? Text(bsum != true ? n1 : n2)
                      : Text(visor.toString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "1";
                            } else {
                              n2 += "1";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                            print('1');
                          });
                        },
                        child: Text("1"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "2";
                            } else {
                              n2 += "2";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("2"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "2";
                            } else {
                              n2 += "2";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("3"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "4";
                            } else {
                              n2 += "4";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("4"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "5";
                            } else {
                              n2 += "5";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("5"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "6";
                            } else {
                              n2 += "6";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("6"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "7";
                            } else {
                              n2 += "7";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("7"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "8";
                            } else {
                              n2 += "8";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("8"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "8";
                            } else {
                              n2 += "8";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("9"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (bsum == false) {
                              n1 += "0";
                            } else {
                              n2 += "0";
                            }
                            visor = "";
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("0"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            bsum = false;
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print(
                              "resultado: ${sum + int.parse(n1) + int.parse(n2)}",
                            );
                            visor += (int.parse(n1) + int.parse(n2)).toString();
                            n1 = "";
                            n2 = "";
                            sum = 0;
                          });
                        },
                        child: Text("="),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            bsum = true;
                            print("operador 1: ${n1}");
                            print("operador 2: ${n2}");
                            print("soma apertado: ${bsum.toString()}");
                            print("resultado: ${sum}");
                          });
                        },
                        child: Text("+"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
