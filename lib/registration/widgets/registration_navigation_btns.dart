import 'package:flutter/material.dart';

class RegistrationNavigationButtons extends StatelessWidget {
  final int currentPageIndex;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSubmit;
  final bool canSubmit; // New parameter to control submit button state

  const RegistrationNavigationButtons({
    Key? key,
    required this.currentPageIndex,
    required this.onNext,
    required this.onPrevious,
    required this.onSubmit,
    this.canSubmit = true, // Default to true for backward compatibility
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        // Previous Button
        if (currentPageIndex > 0)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onPrevious,
              label: const Text('Previous'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        
        if (currentPageIndex > 0) const SizedBox(width: 16),
        
        // Next/Submit Button
        Expanded(
          flex: currentPageIndex == 0 ? 1 : 1,
          child: currentPageIndex < 1
              ? ElevatedButton.icon(
                  onPressed: onNext,
                  label: const Text('Next'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                )
              : ElevatedButton.icon(
                  onPressed: canSubmit ? onSubmit : null,
                  icon: Icon(
                    canSubmit ? Icons.check : Icons.location_off,
                    color: canSubmit ? Colors.white : Colors.grey.shade600,
                  ),
                  label: Text(
                    canSubmit ? 'Submit Registration' : 'Location Required',
                    style: TextStyle(
                      color: canSubmit ? Colors.white : Colors.grey.shade600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canSubmit 
                        ? theme.primaryColor 
                        : Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    elevation: canSubmit ? null : 0,
                  ),
                ),
        ),
      ],
    );
  }
}