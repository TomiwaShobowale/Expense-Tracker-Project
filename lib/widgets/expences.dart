import 'package:expence_tracker/widgets/chart/chart.dart';
import 'package:expence_tracker/widgets/expences_list/expences_list.dart';
import 'package:expence_tracker/widgets/new_expence.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expence.dart';

class Expences extends StatefulWidget {
  const Expences({super.key});
  @override
  State<Expences> createState() {
    return _ExpencesState();
  }
}

class _ExpencesState extends State<Expences> {
  final List<Expence> _registeredExpences = [
    // Expence(
    //   title: "Flutter Course",
    //   amount: 19.99,
    //   date: DateTime.now(),
    //   category: Category.work,
    // ),
    // Expence(
    //   title: "Cinema",
    //   amount: 15.69,
    //   date: DateTime.now(),
    //   category: Category.leisure,
    // ),
  ];

  void _openAddExpenceOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpence(
        onAddExpence: _addExpence,
      ),
    );
  }

  void _addExpence(Expence expence) {
    setState(() {
      _registeredExpences.add(expence);
    });
  }

  void _removeExpence(Expence expence) {
    final expenceIndex = _registeredExpences.indexOf(expence);
    setState(() {
      _registeredExpences.remove(expence);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expence deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpences.insert(expenceIndex, expence);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expences found. Click + to add some."),
    );
    if (_registeredExpences.isNotEmpty) {
      mainContent = ExpencesList(
        expences: _registeredExpences,
        onRemoveExpence: _removeExpence,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Expences"),
        actions: [
          IconButton(
              onPressed: _openAddExpenceOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          Chart(expences: _registeredExpences),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
