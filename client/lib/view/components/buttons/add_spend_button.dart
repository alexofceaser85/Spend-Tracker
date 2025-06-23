import 'package:flutter/material.dart';

class AddButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color borderColor;
  final Color iconColor;
  final Color hoverColor;
  final Color splashColor;

  const AddButton({
    super.key,
    required this.onTap,
    this.borderColor = const Color.fromARGB(255, 11, 131, 0),
    this.iconColor = const Color.fromARGB(255, 11, 131, 0),
    this.hoverColor = const Color.fromARGB(50, 11, 131, 0),
    this.splashColor = const Color.fromARGB(100, 11, 131, 0),
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth < 600 ? screenWidth * 0.17 : 100;
    double fontSize = screenWidth < 600 ? screenWidth * 0.10 : 60; 
    double gapSize = screenWidth  < 600 ? screenWidth * 0.01 : 8;

    return Material(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: borderColor,
          width: 2,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        hoverColor: hoverColor,
        splashColor: splashColor,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 600,
            maxHeight: 140,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: iconSize,
                  color: iconColor,
                ),
                SizedBox(width: gapSize),
                Text(
                  'Add Spend ',
                  style: TextStyle(
                    fontSize: fontSize,
                    color: iconColor, 
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}