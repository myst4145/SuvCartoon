import 'package:flutter/material.dart';

class MyStyle {
  Color primaryColor = Color.fromARGB(255, 105, 205, 146);
  Color secondaryColor = Color(0xff26a69a);
  Color lightColor = Color(0xff64d8cb);
  Color darkColor = Color(0xff00766c);
  Widget showLogo() => Image.asset("images/logo/logo2.png");
  Widget titleH1(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 28, fontWeight: FontWeight.bold, color: secondaryColor),
      );

  Widget titleH2(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: primaryColor),
      );
  Widget titleH3(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w700, color: primaryColor),
      );

  Widget textButton(String string) => Text(
        string,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
      );
  MyStyle() {}

  BoxDecoration boxDecoration() {
    BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white);
  }
}
