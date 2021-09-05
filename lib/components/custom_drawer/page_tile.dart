import 'package:agile_unify/core/app_colors.dart';
import 'package:flutter/material.dart';

class PageTile extends StatelessWidget {
  PageTile({this.label, this.iconData, this.onTap, this.highlighted});

  final String label;
  final IconData iconData;
  final VoidCallback onTap;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: highlighted ? AppColors.purple : Colors.black54),
      ),
      leading: Icon(
        iconData,
        color: highlighted ? AppColors.purple : Colors.black54,
        size: iconData == Icons.bolt ? 28 : 24,
      ),
      onTap: onTap,
    );
  }
}
