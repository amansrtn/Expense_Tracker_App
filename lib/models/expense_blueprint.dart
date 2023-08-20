// ignore_for_file: camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, work, leisure }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.travel: Icons.flight_takeoff,
};

class Expense_BluePrint {
  final String id;
  final String title;
  final double amount;
  final String datetime;
  final Category category;

  Expense_BluePrint(
      {required this.title,
      required this.amount,
      required this.datetime,
      required this.category})
      : id = uuid.v4();

  // String get formattedDate {
  //   return formatter.format(datetime);
  // }
}

// class ExpenseChart {
//   ExpenseChart({required this.category, required this.expenses});
// // adding own constructor
//   ExpenseChart.forCategory(List<Expense_BluePrint> allexpenses, this.category)
//       : expenses = allexpenses
//             .where((expenses) => expenses.category == category)
//             .toList();

//   final Category category;
//   final List<Expense_BluePrint> expenses;

//   double get totalexpense {
//     double sum = 0;
//     for (final expense in expenses) {
//       sum += expense.amount;
//     }
//     return sum;
//   }
// }
