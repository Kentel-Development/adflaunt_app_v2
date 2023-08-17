import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class HostCardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.05087650, size.height * 0.1395173);
    path_0.cubicTo(
        size.width * 0.05087650,
        size.height * 0.1203991,
        size.width * 0.06792460,
        size.height * 0.1049009,
        size.width * 0.08895450,
        size.height * 0.1049009);
    path_0.lineTo(size.width * 0.8242450, size.height * 0.1049009);
    path_0.cubicTo(
        size.width * 0.9083650,
        size.height * 0.1049009,
        size.width * 0.9765570,
        size.height * 0.1668945,
        size.width * 0.9765570,
        size.height * 0.2433673);
    path_0.lineTo(size.width * 0.9765570, size.height * 0.8550891);
    path_0.cubicTo(
        size.width * 0.9765570,
        size.height * 0.9315636,
        size.width * 0.9083650,
        size.height * 0.9935545,
        size.width * 0.8242450,
        size.height * 0.9935545);
    path_0.lineTo(size.width * 0.08895450, size.height * 0.9935545);
    path_0.cubicTo(
        size.width * 0.06792460,
        size.height * 0.9935545,
        size.width * 0.05087650,
        size.height * 0.9780545,
        size.width * 0.05087650,
        size.height * 0.9589364);
    path_0.lineTo(size.width * 0.05087650, size.height * 0.1395173);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.5137170, size.height * 0.1049009),
        Offset(size.width * 1.143180, size.height * 1.229182), [
      Colors.white.withOpacity(1),
      const Color(0xffCDCDCD).withOpacity(1),
      const Color(0xffD2D1D1).withOpacity(1)
    ], [
      0,
      0.246981,
      1
    ]);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.02655760, size.height * 0.1527982);
    path_1.cubicTo(
        size.width * 0.02655760,
        size.height * 0.1336800,
        size.width * 0.04360580,
        size.height * 0.1181818,
        size.width * 0.06463570,
        size.height * 0.1181818);
    path_1.lineTo(size.width * 0.8042450, size.height * 0.1181818);
    path_1.cubicTo(
        size.width * 0.8883650,
        size.height * 0.1181818,
        size.width * 0.9565580,
        size.height * 0.1801755,
        size.width * 0.9565580,
        size.height * 0.2566482);
    path_1.lineTo(size.width * 0.9565580, size.height * 0.8524436);
    path_1.cubicTo(
        size.width * 0.9565580,
        size.height * 0.9289182,
        size.width * 0.8883650,
        size.height * 0.9909091,
        size.width * 0.8042450,
        size.height * 0.9909091);
    path_1.lineTo(size.width * 0.06463570, size.height * 0.9909091);
    path_1.cubicTo(
        size.width * 0.04360570,
        size.height * 0.9909091,
        size.width * 0.02655760,
        size.height * 0.9754091,
        size.width * 0.02655760,
        size.height * 0.9562909);
    path_1.lineTo(size.width * 0.02655760, size.height * 0.1527982);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffECECEC).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(0, size.height * 0.04238900);
    path_2.cubicTo(
        0,
        size.height * 0.02327091,
        size.width * 0.01704810,
        size.height * 0.007772545,
        size.width * 0.03807810,
        size.height * 0.007772545);
    path_2.lineTo(size.width * 0.7710810, size.height * 0.007772545);
    path_2.cubicTo(
        size.width * 0.8552010,
        size.height * 0.007772545,
        size.width * 0.9233930,
        size.height * 0.06976582,
        size.width * 0.9233930,
        size.height * 0.1462382);
    path_2.lineTo(size.width * 0.9233930, size.height * 0.8558755);
    path_2.cubicTo(
        size.width * 0.9233930,
        size.height * 0.9323455,
        size.width * 0.8552010,
        size.height * 0.9943455,
        size.width * 0.7710810,
        size.height * 0.9943455);
    path_2.lineTo(size.width * 0.03807810, size.height * 0.9943455);
    path_2.cubicTo(size.width * 0.01704810, size.height * 0.9943455, 0,
        size.height * 0.9788455, 0, size.height * 0.9597273);
    path_2.lineTo(0, size.height * 0.04238900);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(0, size.height * 0.007772545);
    path_3.lineTo(size.width * 0.08567570, size.height * 0.007772545);
    path_3.lineTo(size.width * 0.08567570, size.height * 1.002991);
    path_3.lineTo(0, size.height * 1.002991);
    path_3.lineTo(0, size.height * 0.007772545);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.shader = ui.Gradient.linear(
        Offset(size.width * 0.04283780, size.height * 0.7772545),
        Offset(size.width * 0.1518800, size.height * 0.7772545),
        [const Color(0xffDADADA).withOpacity(1), Colors.white.withOpacity(0)],
        [0, 0.668008]);
    canvas.drawPath(path_3, paint3Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
