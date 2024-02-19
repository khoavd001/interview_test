import 'package:flutter/material.dart';
import 'package:interview_test/rsc/image_manager.dart';

class CartButton extends StatelessWidget {
  bool selected;
  CartButton({super.key, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(ImagesApp.shoppingIcon)),
        Positioned(
          left: 22,
          top: 0,
          child: Transform(
              transform: Matrix4.identity()..scale(0.3),
              child: Chip(
                label: Text(
                  selected ? '1' : '0',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 35),
                ),
                backgroundColor: Colors.red,
              )),
        )
      ],
    );
  }
}
