import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget chatIcon({String? photoUrl, double height = 76, double width = 76}) {
  return photoUrl != null
      ? ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedNetworkImage(
              fadeInDuration: const Duration(milliseconds: 300),
              fit: BoxFit.fill,
              height: height,
              width: width,
              imageUrl: photoUrl),
        )
      : Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/defaultChatIcon.png'))),
        );
}
