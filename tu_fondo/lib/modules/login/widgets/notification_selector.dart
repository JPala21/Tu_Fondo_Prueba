import 'package:flutter/material.dart';

class NotificationSelector extends StatelessWidget {
  final bool isSms;
  final Function(bool) onChanged;

  const NotificationSelector({
    super.key,
    required this.isSms,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final isDark = colors.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.onSurface.withAlpha(15)),
      ),
      child: Column(
        spacing: 5,
        children: [
          Text(
            'Seleciona el modo de notificacion',
            style: .new(color: isDark ? Colors.white : Colors.black54),
          ),
          Row(
            spacing: 3,
            children: [
              Expanded(
                child: _OptionTile(
                  label: 'SMS',
                  icon: Icons.sms_outlined,
                  isSelected: isSms,
                  onTap: () => onChanged(true),
                ),
              ),
              Expanded(
                child: _OptionTile(
                  label: 'Correo',
                  icon: Icons.alternate_email_rounded,
                  isSelected: !isSms,
                  onTap: () => onChanged(false),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? colors.secondary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? colors.onSecondary
                  : colors.onSurface.withAlpha(128),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? colors.onSecondary
                    : colors.onSurface.withAlpha(128),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
