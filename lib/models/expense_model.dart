import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

List<String> category= ['food','travel','leisure','work' ];

const categoryIcon = {
  'food': Icons.lunch_dining,
  'travel': Icons.flight_takeoff,
  'leisure': Icons.movie,
  'work': Icons.work,
};

class Expense {
  Expense({required this.title,
    required this.amount,
    required this.dateTime,
    required this.category})
      : id = uuid.v4();

  String id;
  String title;
  double amount;
  String dateTime;
  String category;
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  final String category;
  final List<Expense> expenses;

  ExpenseBucket.forCategory(
       List<Expense>allExpenses, this.category)
      :expenses=allExpenses.where((expense) => expense.category ==
      category).toList();

  double get totalExpense {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
