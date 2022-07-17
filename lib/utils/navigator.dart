import 'package:flutter/material.dart';

void navigatorPush(Widget widget, context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => widget));
}
