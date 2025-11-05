import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Database> database;
  int updateId = 0;
  int feitoUpdate = 0;
  String selectedDate = '';

  Future<Database> iniciaDB() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'dados.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE Tarefa(id INTEGER,nome TEXT,data TEXT,feito INTEGER,PRIMARY KEY("id" AUTOINCREMENT))',
        );
      },
      version: 1,
    );
  }

  void insereTarefa(String nome, String data, int feito) async {
    final db = await database;
    await db.transaction((txn) async {
      int id1 = await txn.rawInsert(
        'INSERT INTO Tarefa(nome, data, feito) VALUES(?,?,?)',
        [nome, data, feito],
      );
      setState(() {});
    });
  }

  Future<List<Map<String, dynamic>>> mostraTarefa(String dateFilter) async {
    final db = await database;
    String query = 'SELECT id, nome, data, feito FROM Tarefa';
    if (dateFilter.isNotEmpty) {
      query += ' WHERE data = ?';
      return await db.rawQuery(query, [dateFilter]);
    } else {
      return await db.rawQuery(query);
    }
  }

  void realizaTarefa(int id, int feito) async {
    final db = await database;

    var i = await db.rawUpdate('UPDATE Tarefa SET feito = ? WHERE id = ?', [
      feito == 1 ? 0 : 1,
      id,
    ]);
    setState(() {});
  }

  void atualizarTarefa(String nome, String data, int id, int feito) async {
    final db = await database;

    var i = await db.rawUpdate(
      'UPDATE Tarefa SET nome = ?, data = ?, feito = ? WHERE id = ?',
      [nome, data, feito, id],
    );
    setState(() {});
  }

  String dateFormat(String dateString) {
    try {
      DateTime date = DateTime.parse(dateString);
      String formattedDate =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  @override
  void initState() {
    database = iniciaDB();
    super.initState();
  }

  TextEditingController nomeController = TextEditingController();
  TextEditingController dataController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Projeto")),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            spacing: 1,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        var d = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2200),
                        );
                        selectedDate = dateFormat(d.toString());
                        setState(() {});
                      },
                      child: Text("Filtrar data"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      selectedDate == ""
                          ? "Nenhuma data Selecionada"
                          : selectedDate,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      selectedDate = "";
                      setState(() {});
                    },
                    child: Text("Resetar Filtro"),
                  ),
                ],
              ),

              TextField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome:'),
              ),
              TextField(
                controller: dataController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Data",
                  border: OutlineInputBorder(),
                ),
                onTap: () async {
                  var d = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2200),
                  );
                  if (d != null) {
                    dataController.text = dateFormat(d.toString());
                  }
                },
              ),
              Expanded(
                child: FutureBuilder(
                  future: mostraTarefa(selectedDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    }

                    final items = snapshot.data ?? [];

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final tarefas = items[index];
                        return GestureDetector(
                          onTap: () =>
                              realizaTarefa(tarefas['id'], tarefas['feito']),
                          onLongPress: () {
                            setState(() {
                              nomeController.text = tarefas['nome'];
                              dateFormat(dataController.text = tarefas['data']);
                              feitoUpdate = tarefas['feito'];
                              updateId = tarefas['id'];
                            });
                          },
                          child: ListTile(
                            title: Text('${tarefas['nome']}'),
                            subtitle: Text('${dateFormat(tarefas['data'])}'),
                            trailing: Icon(
                              tarefas['feito'] == 0
                                  ? Icons.check_box_outline_blank
                                  : Icons.check_box,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        onPressed: () {
          if (nomeController.text != "" || dataController.text != "") {
            if (updateId == 0) {
              insereTarefa(nomeController.text, dataController.text, 0);
            } else {
              atualizarTarefa(
                nomeController.text,
                dataController.text,
                updateId,
                feitoUpdate,
              );
              updateId = 0;
            }
          }
          print("Impossivel cadastrar");
          nomeController.text = "";
          dataController.text = "";
        },
        tooltip: 'Increment',
        child: updateId == 0 ? Icon(Icons.add) : Icon(Icons.edit),
      ),
    );
  }
}
