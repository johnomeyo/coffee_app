// Progress Indicator Widget
import 'package:flutter/material.dart';

class RegistrationProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegistrationProgressIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 8 : 0,
                  ),
                  height: 4,
                  decoration: BoxDecoration(
                    color:
                        index <= currentStep
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.outline,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Step ${currentStep + 1} of $totalSteps',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
