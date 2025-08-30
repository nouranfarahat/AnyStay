import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavItem {
  final String label;
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final String route;

  const BottomNavItem({
    required this.label,
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.route});
}

List<BottomNavItem> bottomNavItems=[
  BottomNavItem(label: "Discover", selectedIcon: Icons.explore,unSelectedIcon:Icons.explore_outlined, route: "/home"),
  BottomNavItem(label: "Categories", selectedIcon: Icons.category,unSelectedIcon:Icons.category_outlined, route: "/categories"),
  BottomNavItem(label: "Favorite", selectedIcon: Icons.favorite,unSelectedIcon:Icons.favorite_outline, route: "/favorite"),

];
