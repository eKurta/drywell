import 'package:drivel/services/userService/userService.dart';
import 'package:flutter/material.dart';

Widget userAvatar(double size) {
  return CircleAvatar(
    backgroundColor: Colors.grey.shade300,
    radius: size,
    foregroundImage: UserService.user()!.photoURL != null
        ? NetworkImage(UserService.user()!.photoURL!)
        : null,
  );
}
