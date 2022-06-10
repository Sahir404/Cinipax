import 'package:flutter/material.dart';

import '../constants/constants.dart';

class ShowDualButtons extends StatefulWidget {
  var size;
  String topBtnText;
  String bottomBtnText;
  var showTopButton;
  VoidCallback showBottomPageCallBack;
  VoidCallback showTopPageCallBack;
  int horizontalPadding;
  double horizontalMargin;

  ShowDualButtons({
    required this.size,
    required this.topBtnText,
    required this.bottomBtnText,
    required this.showTopButton,
    required this.showBottomPageCallBack,
    required this.showTopPageCallBack,
    required this.horizontalPadding,
    required this.horizontalMargin,
  });

  @override
  State<ShowDualButtons> createState() => _ShowDualButtonsState();
}

class _ShowDualButtonsState extends State<ShowDualButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: widget.horizontalPadding.toDouble(), vertical: 16),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: widget.horizontalMargin),
        height: 40,
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin: const EdgeInsets.only(left: 4),
                  alignment: Alignment.centerLeft,
                  width: widget.size.width * 0.36,
                  decoration: BoxDecoration(
                    color: widget.showTopButton ? Colors.white : kPrimaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    widget.topBtnText,
                    style: kHeadlineSmall.copyWith(
                      color:
                          widget.showTopButton ? kPrimaryColor : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (widget.showTopButton) getTopStackButton,
          ],
        ),
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
          width: widget.size.width * 0.33,
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
