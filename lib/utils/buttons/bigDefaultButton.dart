import 'package:drivel/utils/sizeConfig.dart';
import 'package:drivel/utils/spacing.dart';
import 'package:flutter/material.dart';

Widget bigDefaultButton(String text, Function()? onTap, context,
    [bool isLoading = false]) {
  return Material(
    color: Theme.of(context).primaryColor,
    borderRadius: BorderRadius.circular(4),
    child: InkWell(
      splashColor: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(4),
      onTap: onTap,
      child: Container(
        height: 64,
        width: SizeConfig.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
            if (isLoading) horizontalSpacing(8),
            if (isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
          ],
        )),
      ),
    ),
  );
}
