import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DefaultScreen extends StatelessWidget {
  const DefaultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      color: Colors.grey,
    );
  }
}
