import 'dart:developer';

import 'package:drivel/utils/widgets/logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget userAvatar(double size) {
  User user = FirebaseAuth.instance.currentUser!;
  return CircleAvatar(
    backgroundColor: Colors.grey.shade300,
    radius: size,
    foregroundImage:
        user.photoURL != null ? NetworkImage(user.photoURL!) : null,
  );
}
