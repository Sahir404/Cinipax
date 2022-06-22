import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../constants/constants.dart';

class ShowDualButtons extends StatefulWidget {
  String topBtnText;
  String bottomBtnText;
  var showTopButton;
  VoidCallback showBottomPageCallBack;
  VoidCallback showTopPageCallBack;
  int topBtnPadding;
  int bottomBtnPadding;
  double marginRight;
  double marginLeft;
  double marginTop;

  ShowDualButtons({
    required this.topBtnText,
    required this.bottomBtnText,
    required this.showTopButton,
    required this.showBottomPageCallBack,
    required this.showTopPageCallBack,
    required this.topBtnPadding,
    required this.bottomBtnPadding,
    required this.marginRight,
    required this.marginLeft,
    required this.marginTop,
  });

  @override
  State<ShowDualButtons> createState() => _ShowDualButtonsState();
}

class _ShowDualButtonsState extends State<ShowDualButtons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(
        left: widget.marginLeft,
        right: widget.marginRight,
        top: widget.marginTop,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          if (!widget.showTopButton) getTopStackButton,
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.showTopPageCallBack();
                  widget.showTopButton = false;
                });
              },
              child: Container(
                height: 34,
                padding: const EdgeInsets.only(left: 6),
                margin: const EdgeInsets.only(left: 4),
                alignment: Alignment.centerLeft,
                width: 32.w - widget.topBtnPadding,
                decoration: BoxDecoration(
                  color: widget.showTopButton ? Colors.white : kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  widget.topBtnText,
                  style: kHeadlineSmall.copyWith(
                    color: widget.showTopButton ? kPrimaryColor : Colors.white,
                  ),
                ),
              ),
            ),
          ),
          if (widget.showTopButton) getTopStackButton,
        ],
      ),
    );
  }

  Widget get getTopStackButton {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.showBottomPageCallBack();
            widget.showTopButton = true;
          });
        },
        child: Container(
          height: 34,
          width: 30.w - widget.bottomBtnPadding,
          padding: const EdgeInsets.only(left: 10, right: 12),
          margin: const EdgeInsets.only(right: 4),
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: widget.showTopButton ? kPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.bottomBtnText,
            style: kHeadlineSmall.copyWith(
              color: widget.showTopButton ? Colors.white : kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
