
import 'package:flutter/widgets.dart';

class RSRotateBox extends StatefulWidget {
  const RSRotateBox({
    Key? key,
    this.turns = .0, //旋转的“圈”数,一圈为360度，如0.25圈即90度
    this.speed = 200, //过渡动画执行的总时长
    required this.child
  }) :super(key: key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  _RSRotateBoxState createState() => _RSRotateBoxState();
}

class _RSRotateBoxState extends State<RSRotateBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        lowerBound: -double.infinity,
        upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }

  /// didUpdateWidget 在很多场合很重要
  @override
  void didUpdateWidget(RSRotateBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    //旋转角度发生变化时执行过渡动画
    if (oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed>0? widget.speed:200),
        curve: Curves.easeOut,
      );
    }
  }
}