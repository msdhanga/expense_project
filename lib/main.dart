import 'package:expense_project/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  List<Transaction> transaction = [
    Transaction(id: 't1', title: 'Mount Abu', amount: 20000, date: DateTime.now()),
    Transaction(id: 't2', title: 'Jaipur', amount: 40000, date: DateTime.now()),
  ];

  void _addTransaction(String title, double amount) {
    if (title.isEmpty || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please insert value in a fields'),
        ),
      );
      return;
    }
    var tre = Transaction(id: 't3', title: title, amount: amount, date: DateTime.now());

    setState(() {
      transaction.add(tre);
    });

    titleController.clear();
    amountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Project'),
      ),
      body: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: amountController,
            decoration: InputDecoration(
              hintText: 'Amount',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTransaction(titleController.text, double.tryParse(amountController.text) ?? 0);
            },
            child: Text('Submit'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('${transaction[index].title}'),
                  subtitle: Text('${DateFormat.yMMMd().format(transaction[index].date)}'),
                  leading: Text('${transaction[index].id}'),
                  trailing: Text('${transaction[index].amount}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
