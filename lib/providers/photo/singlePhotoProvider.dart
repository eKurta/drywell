import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final photoProvider = StateProvider<XFile?>((ref) => null);
