import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WineTypeCard extends StatelessWidget {
  final String imageUrl;
  final String description;
  final String name;
  final String tag;
  final bool isSelected;
  final VoidCallback onTap;

  WineTypeCard({
    required this.imageUrl,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.name,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pink[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center, // Center column contents
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: 145,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Center( // Center the text widget
              child: Text(
                description,
                textAlign: TextAlign.center, // Center the text within its own space
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
