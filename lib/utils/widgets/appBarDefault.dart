import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget {
  final String title;
  final Function()? onIconTap;
  final bool hasIcon;
  const AppBarDefault(
      {Key? key, required this.title, this.onIconTap, this.hasIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (hasIcon)
            GestureDetector(
              onTap: onIconTap ?? () => Navigator.pop(context),
              child: Icon(
                Icons.close,
                size: 32,
              ),
            ),
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 32),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  )))
        ],
      ),
    );
  }
}
