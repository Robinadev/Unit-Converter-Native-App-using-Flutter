import 'package:flutter/material.dart';
import 'unit.dart';

class Category {
  final String name;
  final Color color;
  final List<Unit> units;
  final IconData icon; // Add this property

  const Category({
    required this.name,
    required this.color,
    required this.units,
    required this.icon, // Initialize the icon
  });
}
