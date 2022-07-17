import 'package:drivel/providers/chatProvider.dart/createChatProvider.dart';
import 'package:flutter/material.dart';

class NamedTextField extends StatefulWidget {
  final String name;
  final bool obscureText;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  int? maxLines;

  NamedTextField(
      {Key? key,
      required this.name,
      this.obscureText = false,
      this.controller,
      this.onTap,
      this.onSubmitted,
      this.maxLines = 1,
      this.onChanged})
      : super(key: key);

  @override
  State<NamedTextField> createState() => _NamedTextFieldState();
}

class _NamedTextFieldState extends State<NamedTextField> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.max, children: [
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          widget.name,
          style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextField(
          maxLines: widget.maxLines,
          obscureText: widget.obscureText,
          focusNode: _focusNode,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          controller: widget.controller,
          onSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ),
    ]);
  }
}
