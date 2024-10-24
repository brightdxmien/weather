import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(0.0, size.height - 100);

    var firstControlPoint = Offset(size.width / 2, size.height);
    var firstEndPoint = Offset(size.width, size.height - 100);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class AddInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconColor;
  const AddInfo(
      {super.key,
      required this.icon,
      required this.title,
      required this.value,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: CupertinoColors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              const Color.fromARGB(239, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              SizedBox(
                height: 15,
              ),
              Text(title),
              SizedBox(
                height: 15,
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
      ),
    );
  }
}
