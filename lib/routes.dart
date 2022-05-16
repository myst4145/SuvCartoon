import 'package:demo_app1/wiget/auther.dart';
import 'package:demo_app1/wiget/my_service.dart';
import 'package:demo_app1/wiget/register.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/auther': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => RegisterScreen(),
  '/myService': (BuildContext context) => MyService(),
};
