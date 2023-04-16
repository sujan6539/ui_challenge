import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_challenge/custom_ui/hamburger_menu/hamburger_widget.dart';
import 'package:ui_challenge/data/drinks.dart';

class HeroCard extends StatelessWidget {
  final Drinks drink;

  const HeroCard({Key? key, required this.drink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(4.0),
      height: 0.4 * size.height,
      child: Stack(
        children: [
          ClipPath(
            clipper: HeroPathClipper(),
            child: Container(
                height: 0.36 * size.height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        end: Alignment.topLeft,
                        colors: [drink.color1, drink.color2])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        drink.name,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      padding: const EdgeInsets.all(1),
                      visualDensity: VisualDensity.compact,
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ),
                      selectedIcon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      iconSize: 20,
                    )
                  ],
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Image.asset(
                  drink.image,
                  height: 200,
                )),
          ),
          Positioned(
            bottom: 15,
            left: 0.535 * size.width,
            child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: drink.color1,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: const Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 20,
                )),
          )
        ],
      ),
    );
  }
}

class HeroCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.pink
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    Paint paint2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.8
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(Offset(0.82 * size.width, size.height), 8, paint);
    canvas.drawLine(Offset(0.82 * size.width - 2, size.height - 4),
        Offset(0.84 * size.width, size.height), paint2);
    canvas.drawLine(Offset(0.82 * size.width - 2, size.height + 4),
        Offset(0.84 * size.width, size.height), paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeroPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, height);
    path.lineTo(0.75 * width, height);
    path.quadraticBezierTo(
        0.82 * width, 0.88 * height, 0.8 * width + 20, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
