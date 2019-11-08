import 'package:flutter/material.dart';

class Enemy {
  int health = 200;
  Color enemyColor = Colors.black;
  double x;
  double y;
  Enemy(this.x, this.y);
  Widget build() {
    return new Container(
        padding: const EdgeInsets.all(8.0),
        width: 20,
        height: 20,
        color: enemyColor,
    );
  }
}