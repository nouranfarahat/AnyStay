import 'package:anystay/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const CustomSearchBar(
      {super.key,
      required this.controller,
      this.hintText = "Search for a place...",
      required this.focusNode,
      required this.onChanged,
      required this.onClear});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      cursorColor: AppTheme.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(Icons.search),
        prefixIconColor: AppTheme.primaryColor,
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(onPressed: onClear, icon: Icon(Icons.clear))
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16),
      ),
      onChanged: onChanged,
    );
  }
}
