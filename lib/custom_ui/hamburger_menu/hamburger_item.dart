import 'package:flutter/material.dart';

class HamBurgerItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final bool isSelected;

  const HamBurgerItem({Key? key, required this.child, required this.onTap, required this.isSelected}) : super(key: key);

  @override
  State<HamBurgerItem> createState() => _HamBurgerItemState();
}

class _HamBurgerItemState extends State<HamBurgerItem>{
  late Offset center;
  late bool _isExpanded;

  @override
  Widget build(BuildContext context) {
    _isExpanded = widget.isSelected;
    return GestureDetector(
      onTap: (){
        widget.onTap.call();
        _isExpanded = widget.isSelected;
      },
      child: AnimatedScale(
        scale: _isExpanded ? 1.2 : 0.8,
        duration: Duration(milliseconds: 300),
        curve: Curves.decelerate,
        child: RotatedBox(
          quarterTurns: 3,
          child: widget.child,
        ),
      ),
    );
  }
}



