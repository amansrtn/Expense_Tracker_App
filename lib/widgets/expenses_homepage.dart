// ignore_for_file: non_constant_identifier_names

import "dart:convert";

import "package:expense_tracking/models/expense_blueprint.dart";
import 'package:expense_tracking/widgets/expense_list.dart';
import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "adding_new_expenses.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense_BluePrint> registerexpense = [];
  void AddExpenses() {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: const Color.fromARGB(255, 208, 204, 241),
        context: context,
        builder: (context) => AddNewExpenses(onAddExpense: AddingExpense));
  }

  void AddingExpense(Expense_BluePrint expense) {
    fetchdatafromdatabase();
    // Navigator.pop(context);
  }

  void removeexpense(Expense_BluePrint expense) {
    var index = registerexpense.indexOf(expense);
    setState(() {
      registerexpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expese Removed"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          setState(() {
            registerexpense.insert(index, expense);
          });
        },
      ),
    ));
  }

  void fetchdatafromdatabase() async {
    final url = Uri.https("expensetracker-23135-default-rtdb.firebaseio.com",
        "Expense_Manager.json");
    final response = await http.get(url);
    final Map<String, dynamic> ListData = jsonDecode(response.body);
    final List<Expense_BluePrint> tempexpense = [];
    for (final item in ListData.entries) {
      final cat = Category.values
          .firstWhere((t) => t.toString() == item.value["category"]);
      tempexpense.add(Expense_BluePrint(
          title: item.value['title'],
          amount: item.value['amount'],
          datetime: item.value['datetime'],
          category: cat));
    }
    setState(() {
      registerexpense = tempexpense;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchdatafromdatabase();
  }

  @override
  Widget build(BuildContext context) {
    Widget empty = const Center(
      child: Text(
        "No Expenses Found...Try Adding Expenses",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
    if (registerexpense.isNotEmpty) {
      empty = ExpenseList(
        currentexpense: registerexpense,
        onremoveexpense: removeexpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                AddExpenses();
              },
              icon: const Icon(
                Icons.add_circle_outlined,
                color: Colors.black,
              ),
              label: const Text(
                "Add Expenses",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50.0,
          ),
          Expanded(child: empty)
        ],
      ),
    );
  }
}
