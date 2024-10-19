import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  const AddInfo({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CupertinoColors.transparent,
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            Icon(
              icon,
              color: CupertinoColors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(title),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
