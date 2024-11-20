import 'package:flutter/material.dart';
import 'category.dart';

class Backdrop extends StatefulWidget {
  final Widget frontPanel;
  final Widget backPanel;
  final Widget frontTitle;
  final Widget backTitle;
  final Category currentCategory;

  const Backdrop({
    Key? key,
    required this.frontPanel,
    required this.backPanel,
    required this.frontTitle,
    required this.backTitle,
    required this.currentCategory,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.backPanel, // Background panel
        widget.frontPanel, // Foreground panel
      ],
    );
  }
}
