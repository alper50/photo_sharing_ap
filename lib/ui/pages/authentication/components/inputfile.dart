import 'package:flutter/material.dart';
import 'package:greenlive/ui/pages/authentication/components/custombutton.dart';
class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final bool? ispasw;
  final TextEditingController? controller;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.ispasw,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: TextField(
        textInputAction: TextInputAction.done,
        controller: controller,
        obscureText: ispasw!?true:false,
        onChanged: onChanged,
        cursorColor: Colors.green,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.green,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}