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
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : theme.primaryColor,
          foregroundColor:
              isOutlined ? theme.primaryColor : theme.colorScheme.onPrimary,
          elevation: isOutlined ? 0 : 2,
          shadowColor: theme.primaryColor.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side:
                isOutlined
                    ? BorderSide(color: theme.primaryColor)
                    : BorderSide.none,
          ),
        ),
        child:
            isLoading
                ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isOutlined
                          ? theme.primaryColor
                          : theme.colorScheme.onPrimary,
                    ),
                  ),
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
