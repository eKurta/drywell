import 'package:flutter_riverpod/flutter_riverpod.dart';

var searchStateProvider = StateProvider<bool>((ref) => false);

var searchTextStateProvider = StateProvider<String>((ref) => '');
