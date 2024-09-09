import 'package:expence_tracker/models/expence.dart';
import 'package:flutter/material.dart';

class ExpenceItem extends StatelessWidget {
  const ExpenceItem(this.expence, {super.key});

  final Expence expence;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expence.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text("\$${expence.amount.toStringAsFixed(2)}"),
                const Spacer(), //Takes all
                Row(
                  children: [
                    Icon(categoryIcons[expence.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expence.formattedDate)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
