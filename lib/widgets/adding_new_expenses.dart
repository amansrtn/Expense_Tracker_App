// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:expense_tracking/models/expense_blueprint.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewExpenses extends StatefulWidget {
  const AddNewExpenses({super.key, required this.onAddExpense});

  final void Function(Expense_BluePrint expense) onAddExpense;
  @override
  State<AddNewExpenses> createState() => _AddNewExpensesState();
}

final url = Uri.https(
    "expensetracker-23135-default-rtdb.firebaseio.com", "Expense_Manager.json");

class _AddNewExpensesState extends State<AddNewExpenses> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? selecteddate;
  Category selectedcategory = Category.travel;

  void datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime.now();
    final val = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      selecteddate = val;
    });
  }

  void submitexpense() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    if (_titlecontroller.text.trim().isEmpty == true ||
        enteredamount == null ||
        selecteddate == null) {
      showDialog(
          context: context,
          builder: (context) => Center(
                  child: AlertDialog(
                      icon: const Icon(
                        Icons.cancel_presentation_sharp,
                        color: Colors.red,
                        size: 50,
                      ),
                      title: const Center(
                        child: Text(
                          "Invalid Entry",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 223, 20, 6),
                          ),
                        ),
                      ),
                      content: const Text(
                        "First Fill All Data Then Submit",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: const Color.fromARGB(238, 0, 0, 0),
                      actions: [
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 13, 245, 32),
                                fixedSize: const Size(140, 40)),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Back To Form",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            )))
                  ])));
    } else {
      http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "title": _titlecontroller.text,
            "amount": double.parse(_amountcontroller.text),
            "datetime": selecteddate!.toString(),
            "category": selectedcategory.toString()
          }));
      Navigator.of(context).pop();
      widget.onAddExpense(Expense_BluePrint(
          title: _titlecontroller.text,
          amount: double.parse(_amountcontroller.text),
          datetime: selecteddate.toString(),
          category: selectedcategory));
    }
  }

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 300, left: 16, right: 16),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 30,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: "Expense Name",
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  maxLength: 30,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount Of Expense",
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selecteddate == null
                        ? "Select Date"
                        : formatter.format(selecteddate!)),
                    IconButton(
                        onPressed: () {
                          datepicker();
                        },
                        icon: const Icon(Icons.calendar_month_outlined))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              DropdownButton(
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedcategory = value;
                    }
                  });
                },
                value: selectedcategory,
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 223, 6, 6)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 20, 239, 8)),
                  onPressed: () {
                    submitexpense();
                  },
                  child: const Text(
                    "Submit Expense",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
