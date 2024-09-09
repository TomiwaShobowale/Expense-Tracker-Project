import 'package:expence_tracker/widgets/expences_list/expence_item.dart';
import 'package:flutter/material.dart';
import 'package:expence_tracker/models/expence.dart';

class ExpencesList extends StatelessWidget {
  const ExpencesList(
      {super.key, required this.expences, required this.onRemoveExpence});

  final List<Expence> expences;
  final void Function(Expence expence) onRemoveExpence;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expences.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(expences[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                    horizontal: Theme.of(context).cardTheme.margin!.horizontal),
              ),
              onDismissed: (direction) {
                onRemoveExpence(expences[index]);
              },
              child: ExpenceItem(expences[index]),
            ));
  }
//   ThemeData.dark().copyWith( // dark() no longer takes any arguments
//   useMaterial3: true,
//   colorScheme: kColorScheme,
//   cardTheme: ...
// )
}
