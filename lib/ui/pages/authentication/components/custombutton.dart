import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget? child;
  final Function? onpressed;
  const CustomContainer({
    Key? key,
    this.child, this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onpressed as void Function()?,
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.8,
          decoration: BoxDecoration(
      color: Colors.grey[400]!.withOpacity(0.7),
      borderRadius: BorderRadius.circular(25),
          ),
          child: child,
        ),
    );
  }
}
