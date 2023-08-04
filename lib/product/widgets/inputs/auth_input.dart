import 'package:adflaunt/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../generated/l10n.dart';

class AuthInput extends StatefulWidget {
  /// Creates a new `AuthInput`.
  const AuthInput({
    required this.controller,
    required this.repeatController,
    super.key,
    this.placeholder,
    this.keyBoardType,
    this.hasPassword = false,
    this.hasMargin = true,
    this.enabled = true,
    this.onTap,
  });

  /// The placeholder for this `AuthInput`.
  final String? placeholder;

  /// The keyboard type for this `AuthInput`.
  final TextInputType? keyBoardType;

  /// Whether this `AuthInput` has a password.
  final bool? hasPassword;

  /// Whether this `AuthInput` has a margin.
  final dynamic hasMargin;

  /// The controller for this `AuthInput`.
  final TextEditingController controller;

  /// The controller for the repeat password `AuthInput`.
  final TextEditingController? repeatController;

  /// Whether this `AuthInput` is enabled.
  final bool enabled;

  /// The function to be called when this `AuthInput` is tapped.
  final void Function()? onTap;

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: widget.hasMargin == true ? 20 : 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: TextFormField(
          onTap: widget.onTap,
          enabled: widget.enabled,
          readOnly:
              // ignore: avoid_bool_literals_in_conditional_expressions
              widget.keyBoardType == TextInputType.datetime ? true : false,
          validator: (value) {
            if (value!.isEmpty) {
              return widget.keyBoardType == TextInputType.datetime
                  ? S.of(context).pleaseSelectADate
                  : S.of(context).pleaseEnterAText;
            }
            if (widget.hasPassword! == true) {
              if (value.length < 6) {
                return S.of(context).passwordMustBeAtLeast6Characters;
              }
            }
            if (widget.repeatController != null) {
              if (value != widget.repeatController!.text) {
                return S.of(context).passwordDoesNotMatch;
              }
            }
            if (widget.keyBoardType == TextInputType.emailAddress) {
              if (!value.contains('@') || !value.contains('.')) {
                return S.of(context).pleaseEnterAValidEmailAddress;
              }
            }
            if (widget.keyBoardType == TextInputType.phone) {
              if (value.length < 10) {
                return S.of(context).pleaseEnterAValidPhoneNumber;
              }
            }

            return null;
          },
          controller: widget.controller,
          cursorColor: const Color.fromRGBO(119, 118, 130, 1),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color.fromRGBO(119, 118, 130, 1),
          ),
          inputFormatters: widget.keyBoardType == TextInputType.phone
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15)
                ]
              : [LengthLimitingTextInputFormatter(50)],
          keyboardType: widget.keyBoardType,
          // ignore: avoid_bool_literals_in_conditional_expressions
          obscureText: widget.hasPassword! ? _passwordVisible : false,
          decoration: InputDecoration(
            prefix: widget.keyBoardType == TextInputType.phone
                ? const SizedBox(
                    width: 105,
                  )
                : const SizedBox(),
            contentPadding:
                const EdgeInsets.only(top: 14, bottom: 9, left: 22, right: 22),
            hintText: widget.placeholder,
            hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color.fromRGBO(119, 118, 130, 1),
            ),
            suffixIcon: widget.hasPassword! == true
                ? IconButton(
                    icon: Icon(
                      _passwordVisible == true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorConstants.colorTertiary,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  )
                : const SizedBox.shrink(),
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: ColorConstants.colorTertiary,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                width: 2,
                color: ColorConstants.colorTertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
