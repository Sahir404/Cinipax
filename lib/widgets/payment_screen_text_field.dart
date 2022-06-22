import 'package:flutter/material.dart';

import '../constants/constants.dart';

class PaymentScreenTextField extends StatelessWidget {
  String textFieldLabel;
  String textFieldHint;
  double marginLeft;
  double marginRight;

  PaymentScreenTextField({
    required this.textFieldLabel,
    required this.textFieldHint,
    required this.marginLeft,
    required this.marginRight,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 38),
          child: Text(
            textFieldLabel,
            style: kUserAuthSubTitle.copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: marginLeft,
            right: marginRight,
            top: 8,
          ),
          height: 40,
          child: TextFormField(
            style: kUserAuthSubTitle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w100,
            ),
            decoration: InputDecoration(
              hintText: textFieldHint,
              fillColor: kPaymentScreenTextFieldColor,
              filled: true,
              hintStyle: kUserAuthSubTitle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 6,
                horizontal: 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPaymentScreenTextFieldColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: kPaymentScreenTextFieldColor,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
        ),
      ],
    );
  }
}
