import 'package:anystay/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterChipWidget extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color? selectedColor;
  final Color? backgroundColor;

  const FilterChipWidget({super.key, required this.label, required this.selected, required this.onSelected, this.selectedColor, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
        label: Text(label,
        style:TextStyle(
          color: selected? AppTheme.primaryColor:AppTheme.textColor,
          fontWeight: FontWeight.w600
        ),),
        selected: selected,
        onSelected: onSelected,
    checkmarkColor: AppTheme.primaryColor,
    selectedColor: selectedColor??AppTheme.secondaryColor,
    backgroundColor: backgroundColor??Colors.grey[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
    );
  }
}
