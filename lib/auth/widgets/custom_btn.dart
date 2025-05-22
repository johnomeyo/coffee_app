// Custom Button Component
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 56,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,

        child:
            isLoading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator.adaptive(),
                )
                : Text(
                  text,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color:
                        isOutlined
                            ? theme.primaryColor
                            : theme.colorScheme.onPrimary,
                  ),
                ),
      ),
    );
  }
}
