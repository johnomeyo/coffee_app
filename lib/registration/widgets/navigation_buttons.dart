// Navigation Buttons Widget
import 'package:flutter/material.dart';

class RegistrationNavigationButtons extends StatelessWidget {
  final int currentPageIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;

  const RegistrationNavigationButtons({
    Key? key,
    required this.currentPageIndex,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          if (currentPageIndex > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onPrevious,
                child: const Text('Previous'),
              ),
            ),
          if (currentPageIndex > 0) const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: currentPageIndex == 1 ? onSubmit : onNext,
              child: Text(currentPageIndex == 1 ? 'Submit' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }
}
