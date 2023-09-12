import 'package:aokiji_s_application4/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class SquareItemWidget extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  SquareItemWidget({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  _SquareItemWidgetState createState() => _SquareItemWidgetState();
}

class _SquareItemWidgetState extends State<SquareItemWidget> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Container(
        width: getHorizontalSize(150),
        height: getHorizontalSize(150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: _isPressed ? Colors.blue.shade100 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: EdgeInsets.all(getHorizontalSize(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              size: getSize(64),
              color: Colors.black, // Customize the icon color
            ),
            SizedBox(height: getSize(12)),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black, // Customize the text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}

