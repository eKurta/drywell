import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/view/explore/stateProviders/searchStateProviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchBar extends ConsumerWidget {
  final EdgeInsets padding;

  const SearchBar({Key? key, this.padding = EdgeInsets.zero}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: padding,
      child: Container(
        height: 45,
        width: SizeConfig.width,
        decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.6),
            borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 12),
          child: TextField(
            onChanged: (search) {
              ref.read(searchTextStateProvider.notifier).state = search;
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search for a chat',
                hintStyle: TextStyle(color: Colors.grey.shade500)),
          ),
        ),
      ),
    );
  }
}
