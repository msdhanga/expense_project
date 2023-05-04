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
  final descriptionController = TextEditingController();
  List<Transaction> transaction = [
    Transaction(id: 't1', title: 'Mount Abu', amount: 20000, date: DateTime.now(),description: 'nice'),
    Transaction(id: 't2', title: 'Jaipur', amount: 40000, date: DateTime.now(),description: 'good'),
  ];

  void _addTransaction(String title, double amount,String Desc) {
    if (title.isEmpty || amount <= 0 ) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please insert value in a fields'),
        ),
      );
      return;
    }

    var tre = Transaction(id: 't3', title: title, amount: amount, date: DateTime.now(),description: Desc);

    setState(() {
      transaction.add(tre);
    });

    titleController.clear();
    amountController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Project'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.text,
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.location_city),
                prefixIconColor: Colors.blue,
                labelText: 'Title',
                hintText: 'Title',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: amountController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.currency_rupee),
                prefixIconColor: Colors.blue,
                labelText: 'Amount',
                hintText: 'Amount',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            child: TextFormField(
              maxLines: 3,
              keyboardType: TextInputType.text,
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.description),
                prefixIconColor: Colors.blue,
                labelText: 'Description',
                hintText: 'Enter Description',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addTransaction(titleController.text,double.tryParse(amountController.text) ?? 0,descriptionController.text);
            },
            child: Text('Submit'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      Text('${transaction[index].title}'),
                      Text('${DateFormat.yMMMd().format(transaction[index].date)}'),
                      Text('${transaction[index].id}'),
                      Text('${transaction[index].amount}'),
                      Text('${transaction[index].description}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
