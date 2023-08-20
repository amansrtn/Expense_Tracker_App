// ignore_for_file: must_be_immutable

import "package:expense_tracking/models/expense_blueprint.dart";
import "package:expense_tracking/widgets/showing_expense_list.dart";
import "package:flutter/material.dart";

class ExpenseList extends StatelessWidget {
  ExpenseList(
      {super.key, required this.currentexpense, required this.onremoveexpense});

  List<Expense_BluePrint> currentexpense;
  void Function(Expense_BluePrint expense) onremoveexpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: currentexpense.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(currentexpense[index]),
        background: Container(
          color: const Color.fromARGB(220, 243, 20, 4),
        ),
        onDismissed: (direction) => {onremoveexpense(currentexpense[index])},
        child: ShowExpense(currentexpense: currentexpense[index]),
      ),
    );
  }
}
