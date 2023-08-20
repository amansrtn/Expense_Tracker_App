import 'package:expense_tracking/models/expense_blueprint.dart';
import 'package:flutter/material.dart';

class ShowExpense extends StatelessWidget {
  const ShowExpense({super.key, required this.currentexpense});

  final Expense_BluePrint currentexpense;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 235, 194, 208),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                currentexpense.title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(currentexpense.amount.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[currentexpense.category]),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(currentexpense.datetime,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(currentexpense.category.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold))
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
