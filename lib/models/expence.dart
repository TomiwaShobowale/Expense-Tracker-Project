import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work, other }

const uuid = Uuid();
const categoryIcons = {
  Category.food: Icons.lunch_dining_rounded,
  Category.travel: Icons.flight_takeoff_rounded,
  Category.leisure: Icons.movie_rounded,
  Category.work: Icons.work_rounded,
  Category.other: Icons.question_mark_sharp,
};

class Expence {
  Expence({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenceBucket {
  const ExpenceBucket({required this.category, required this.expences});

  ExpenceBucket.forCategory(List<Expence> allExpences, this.category)
      : expences = allExpences
            .where((expence) => expence.category == category)
            .toList();
  final Category category;
  final List<Expence> expences;

  double get totalExpences {
    double sum = 0;

    for (final expence in expences) {
      sum += expence.amount;
    }
    return sum;
  }
}
