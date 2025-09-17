import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalendarPage(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  static List<String> monthNames = [
    "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho",
    "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

    DateTime lastDay = DateTime(year, month + 1, 0);

    List<DateTime> days = List.generate(
      lastDay.day,
      (index) => DateTime(year, month, index + 1),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("${monthNames[month - 1]} $year"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: days.length,
        itemBuilder: (context, index) {
          DateTime day = days[index];
          return TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue.shade50,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DayDetailPage(day: day),
                ),
              );
            },
            child: Text(
              '${day.day}',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          );
        },
      ),
    );
  }
}

class DayDetailPage extends StatelessWidget {
  final DateTime day;

  const DayDetailPage({super.key, required this.day});

  static const List<String> weekdayNames = [
    "Segunda-feira",
    "Terça-feira",
    "Quarta-feira",
    "Quinta-feira",
    "Sexta-feira",
    "Sábado",
    "Domingo"
  ];

  @override
  Widget build(BuildContext context) {
    String weekday = weekdayNames[day.weekday - 1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Dia"),
      ),
      body: Center(
        child: Text(
          "$weekday, ${day.day}",
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
