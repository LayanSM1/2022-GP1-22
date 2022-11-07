import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../classes/Validators.dart';
import 'custom_text_form_field.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Function(String)? validator;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const PasswordTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.validator,
    this.keyboardType = TextInputType.visiblePassword,
    this.textInputAction = TextInputAction.next,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _hidePassword = true;

  get validator => null;

  void toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      validator: validator ?? Validators.validatePassword,
      suffix: PasswordVisibilityIcon(
        onPressed: toggleVisibility,
        value: _hidePassword,
      ),
    );
  }
}

class PasswordVisibilityIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final bool value;

  const PasswordVisibilityIcon({
    Key? key,
    required this.onPressed,
    this.value = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        value ? Icons.remove_red_eye: Icons.remove_red_eye_outlined,
        color: Colors.black87,
        size: 18,
      ),
    );
  }
}
