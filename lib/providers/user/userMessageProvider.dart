import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drivel/services/userService/userService.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var userMessageProvider = StateProvider<int>((ref) {
  getNumberOfUserMessages() async {
    var firebaseData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(UserService.user()!.uid)
        .get();
    print(firebaseData.data()!['numberOfMessagesWritten']);
  }

  return 0;
});
