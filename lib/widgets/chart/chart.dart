import 'package:flutter/material.dart';

import 'package:expence_tracker/widgets/chart/chart_bar.dart';
import 'package:expence_tracker/models/expence.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expences});

  final List<Expence> expences;

  List<ExpenceBucket> get buckets {
    return [
      ExpenceBucket.forCategory(expences, Category.food),
      ExpenceBucket.forCategory(expences, Category.leisure),
      ExpenceBucket.forCategory(expences, Category.travel),
      ExpenceBucket.forCategory(expences, Category.work),
      ExpenceBucket.forCategory(expences, Category.other),
    ];
  }

  double get maxTotalExpence {
    double maxTotalExpence = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpences > maxTotalExpence) {
        maxTotalExpence = bucket.totalExpences;
      }
    }

    return maxTotalExpence;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpences == 0
                        ? 0
                        : bucket.totalExpences / maxTotalExpence,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
