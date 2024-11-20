import 'package:flutter/material.dart';
import 'category.dart';

class CategoryTile extends StatelessWidget {
  final Category category;
  final bool isDisabled; // Indicates if the category is disabled
  final VoidCallback onTap;

  const CategoryTile({
    Key? key,
    required this.category,
    this.isDisabled = false, // Default to false if not explicitly provided
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap, // Disable interaction if isDisabled
      child: Container(
        decoration: BoxDecoration(
          color: isDisabled
              ? category.color.withOpacity(0.5) // Dim color if disabled
              : category.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category.icon,
                size: 40.0,
                color: isDisabled ? Colors.grey : Colors.white,
              ),
              const SizedBox(height: 8.0),
              Text(
                category.name,
                style: TextStyle(
                  fontSize: 18.0,
                  color: isDisabled ? Colors.grey : Colors.white,
                ),
              ),
              if (isDisabled)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Unavailable',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
