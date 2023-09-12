import 'package:aokiji_s_application4/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class Square2screen extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  Square2screen({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  _Square2screenState createState() => _Square2screenState();
}

class _Square2screenState extends State<Square2screen> {
  bool _isPressed = false;

  @override
 Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: double.maxFinite,
        height: getHorizontalSize(100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _isPressed ? Colors.blue.shade100 : Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1.5,
          ),
        ),
        padding: EdgeInsets.all(getHorizontalSize(16)),
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: getSize(32),
              color: Colors.blue, // Customize the icon color
            ), // Icon
            SizedBox(width: getSize(12)), // Spacing between Icon and Text
            Flexible( // Add Flexible to ensure title wraps
              child: Container(
                padding: EdgeInsets.all(getHorizontalSize(12)),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    overflow: TextOverflow.clip // Customize the text color
                  ),
                  overflow: TextOverflow.clip
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
