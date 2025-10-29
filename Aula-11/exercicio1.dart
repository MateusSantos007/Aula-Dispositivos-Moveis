import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'dados.db'),
    onCreate: (db, version) {
      return db.execute(
        '''CREATE TABLE Memoria(id INTEGER PRIMARY KEY, memoria TEXT);''',
      );
    },
    version: 1,
  );
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
  var operador = "";
  var visor = "";

  void digitar(String number) {
    setState(() {
      if (bsum == false) {
        n1 += number;
      } else {
        n2 += number;
      }
      visor = "";
    });
  }

  void calcular(String operador) {
    if (n1 != "" && n2 != "") {
      setState(() {
        bsum = false;
        if (operador == "/") {
          visor += (int.parse(n1) / int.parse(n2)).toString();
        }
        if (operador == "*") {
          visor += (int.parse(n1) * int.parse(n2)).toString();
        }
        if (operador == "-") {
          visor += (int.parse(n1) - int.parse(n2)).toString();
        }
        if (operador == "+") {
          visor += (int.parse(n1) + int.parse(n2)).toString();
        }
        n1 = "";
        n2 = "";
      });
    }
  }

  Future<void> addMemoria(Memoria memoria) async {
    final db = await openDatabase(join(await getDatabasesPath(), 'dados.db'));

    var mem = await listMemoria();

    if (mem.isEmpty) {
      await db.insert(
        'Memoria',
        memoria.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      memoria.memoria = (int.parse(memoria.memoria) + int.parse(mem[0].memoria))
          .toString();
      memoria.id = mem[0].id;
      await db.update(
        'Memoria',
        memoria.toMap(),
        where: 'id = ?',
        whereArgs: [memoria.id],
      );
    }
  }

  Future<void> subMemoria(Memoria memoria) async {
    final db = await openDatabase(join(await getDatabasesPath(), 'dados.db'));

    var mem = await listMemoria();

    if (mem.isEmpty) {
      await db.insert(
        'Memoria',
        memoria.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      memoria.memoria = (int.parse(memoria.memoria) - int.parse(mem[0].memoria))
          .toString();
      memoria.id = mem[0].id;
      await db.update(
        'Memoria',
        memoria.toMap(),
        where: 'id = ?',
        whereArgs: [memoria.id],
      );
    }
  }

  Future<List<Memoria>> listMemoria() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'dados.db'));
    ;

    final List<Map<String, Object?>> result = await db.query('Memoria');

    return [
      for (final {'id': id as int, 'memoria': memoria as String} in result)
        Memoria(id: id, memoria: memoria),
    ];
  }

  Future<void> deleteMemoria() async {
    final db = await openDatabase(join(await getDatabasesPath(), 'dados.db'));

    var mem = await listMemoria();

    if (!mem.isEmpty) {
      await db.delete('Memoria', where: 'id = ?', whereArgs: [mem[0].id]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text("Calculadora"), centerTitle: true),
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
                          digitar("1");
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
                          digitar("2");
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
                          digitar("3");
                        },
                        child: Text("3"),
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
                            operador = "/";
                          });
                        },
                        child: Text("/"),
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
                          digitar("4");
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
                          digitar("5");
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
                          digitar("6");
                        },
                        child: Text("6"),
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
                            operador = "*";
                          });
                        },
                        child: Text("*"),
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
                          digitar("7");
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
                          digitar("8");
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
                          digitar("9");
                        },
                        child: Text("9"),
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
                            operador = "-";
                          });
                        },
                        child: Text("-"),
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
                        onPressed: () async {
                          var r = await listMemoria();
                          if (!r.isEmpty) {
                            setState(() {
                              visor = "";
                              if (bsum) {
                                n2 = r[0].memoria;
                              } else {
                                n1 = r[0].memoria;
                              }
                            });
                          }
                        },
                        child: Text("MR"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          digitar("0");
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
                          calcular(operador);
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
                            operador = "+";
                          });
                        },
                        child: Text("+"),
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
                        onPressed: () async {
                          deleteMemoria();
                        },
                        child: Text("MC"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (visor == "" && n2 != "") {
                              addMemoria(Memoria(memoria: n2, id: null));
                            }
                            if (n2 == "" && n1 != "") {
                              addMemoria(Memoria(memoria: n1, id: null));
                            }
                            if (visor != "") {
                              addMemoria(Memoria(memoria: visor, id: null));
                            }
                          });
                        },
                        child: Text("M+"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            if (visor == "" && n2 != "") {
                              subMemoria(Memoria(memoria: n2, id: null));
                            }
                            if (n2 == "" && n1 != "") {
                              subMemoria(Memoria(memoria: n1, id: null));
                            }
                            if (visor != "") {
                              subMemoria(Memoria(memoria: visor, id: null));
                            }
                          });
                        },
                        child: Text("M-"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            n1 = "";
                            n2 = "";
                            bsum = false;
                            visor = "";
                          });
                        },
                        child: Text("C"),
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

class Memoria {
  int? id;
  String memoria;
  Memoria({required this.memoria, required this.id});

  Map<String, Object?> toMap() {
    return {'id': id, 'memoria': memoria};
  }

  @override
  String toString() {
    return 'Memoria{id: $id, memoria: $memoria}';
  }
}
