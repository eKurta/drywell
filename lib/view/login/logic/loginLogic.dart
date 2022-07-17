import 'package:drivel/view/explore/pages/explorePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<bool> login(String email, String password, context) async {
  try {
    final user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    if (user != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => ExplorePage()));
    }
  } catch (e) {
    print('error signin $e');
    return false;
  }

  return true;
}

void resetSigninError(WidgetRef ref) {
  ref.refresh(signinErrorProvider);
}

final signinErrorProvider = StateProvider<String>((ref) => '');
