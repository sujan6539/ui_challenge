import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_challenge/custom_ui/hamburger_menu/hamburger_item.dart';

class HamBurgerWidget extends StatefulWidget {
  const HamBurgerWidget({Key? key}) : super(key: key);

  @override
  State<HamBurgerWidget> createState() => _HamBurgerWidgetState();
}

class _HamBurgerWidgetState extends State<HamBurgerWidget>
    with SingleTickerProviderStateMixin {
  final List<GlobalKey> _keys = List.generate(4, (_) => GlobalKey());
  List<WidgetData> _childCenters = [];
  int selectedIndex = 0;
  int prevSelectedIndex = 0;
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getChildCenters();
      animation = Tween<double>(
              begin: _childCenters[prevSelectedIndex].center.dy,
              end: _childCenters[selectedIndex].center.dy)
          .animate(animationController);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _getChildCenters() {
    List<WidgetData> childCenters = [];
    for (final key in _keys) {
      final RenderBox? box =
          key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        //Offset center = box.size.center(box.localToGlobal(Offset.zero));
        Offset center = box.localToGlobal(Offset.zero);
        // center = Offset(center.dx, center.dy - box.size.height/2);

        debugPrint(center.toString());
        childCenters.add(WidgetData(center: center, size: box.size));
      }
    }
    setState(() => _childCenters = childCenters);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var widgetSize = Size(0.2 * size.width, size.height);
    if (_childCenters.isNotEmpty) {
      animation = Tween<double>(
              begin: _childCenters[prevSelectedIndex].center.dy,
              end: _childCenters[selectedIndex].center.dy)
          .animate(animationController);
    }
    debugPrint(_childCenters.length.toString());
    return Stack(
      children: [
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => ClipPath(
            clipBehavior: Clip.antiAlias,
            clipper: (selectedIndex >= _childCenters.length)
                ? null
                : MyCustomClipper(
                    childCenter: _childCenters[selectedIndex],
                    radius: 10,
                    width: widgetSize.width,
                    value: animation.value),
            child: Container(
              width: widgetSize.width,
              height: widgetSize.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.pink.shade400, Colors.pink.shade800]),
                  borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(20.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Padding(padding: EdgeInsets.all(16.0)),
                  HamBurgerItem(
                    key: _keys[0],
                    isSelected: (selectedIndex == 0)? true : false ,
                    child: const Text(
                      "Shake",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      animationController.reset();
                      animationController.forward();
                      setState(() {
                        prevSelectedIndex = selectedIndex;
                        selectedIndex = 0;
                      });
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  HamBurgerItem(
                    key: _keys[1],
                    isSelected: (selectedIndex == 1)? true : false ,
                    child: const Text("Coffee",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      debugPrint("click");
                      animationController.reset();
                      animationController.forward();
                      setState(() {
                        prevSelectedIndex = selectedIndex;
                        selectedIndex = 1;
                      });
                      //animationController.reset();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  HamBurgerItem(
                    key: _keys[2],
                    isSelected: (selectedIndex == 2)? true : false ,
                    child: const Text("Drinks",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      animationController.reset();
                      animationController.forward();
                      setState(() {
                        prevSelectedIndex = selectedIndex;
                        selectedIndex = 2;
                      });
                      //animationController.reset();
                    },
                  ),
                  const Padding(padding: EdgeInsets.all(16.0)),
                  HamBurgerItem(
                    key: _keys[3],
                    isSelected: (selectedIndex == 3)? true : false ,
                    child: const Text("Cocktail",
                        style: TextStyle(color: Colors.white)),
                    onTap: () {
                      animationController.reset();
                      animationController.forward();
                      setState(() {
                        prevSelectedIndex = selectedIndex;
                        selectedIndex = 3;
                      });
                      //animationController.reset();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: animationController,
          builder: (context, child) => CustomPaint(
            painter: (_childCenters.length == 0)
                ? null
                : MyPainter(
                    offset: _childCenters[selectedIndex],
                    width: size.width * 0.2,
                    value: animation.value),
          ),
        ),
      ],
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final WidgetData childCenter;
  final double radius;
  final double delta = 20;
  final double deltaX = 5;
  final double width;
  double value;

  MyCustomClipper(
      {required this.childCenter,
      required this.radius,
      required this.width,
      required this.value});

  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(width, 0);
    path.lineTo(width, value - radius - delta);
    path.quadraticBezierTo(width, value - delta, width - radius, value - 12);
    // path.lineTo(0.9 * width, value + delta);
    path.cubicTo(
        0.7 * width, value, 0.7 * width, value, 0.9 * width, value + delta - 5);
    path.quadraticBezierTo(
        width, value + delta, width, value + radius + delta + 15);
    path.lineTo(width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class MyPainter extends CustomPainter {
  WidgetData offset;
  final double width;
  double value;

  MyPainter({required this.offset, required this.width, required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.yellow.shade700
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    debugPrint("...." + value.toString());
    canvas.drawCircle(Offset(width - 5, value), 5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WidgetData {
  final Offset center;
  final Size size;

  WidgetData({required this.center, required this.size});
}
