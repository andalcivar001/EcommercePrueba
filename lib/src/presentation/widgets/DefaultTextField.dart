import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  IconData icon;
  TextInputType textInputType;
  bool obscureText = false;
  String? initialValue;
  Function(String)? onChanged;
  String? Function(String?)? validator;
  TextEditingController? controller;
  bool readOnly;
  VoidCallback? onTap;
  TextInputAction? textInputAction;
  Iterable<String>? autofillHints;
  int maxLines;
  String hinText;

  DefaultTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChanged,
    this.validator,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.textInputAction,
    this.autofillHints,
    this.maxLines = 1,
    this.hinText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      obscureText: obscureText,
      initialValue: controller == null ? initialValue : null,
      onChanged: (text) {
        onChanged!(text);
      },
      onTap: onTap,
      keyboardType: textInputType,
      validator: validator,
      decoration: _inputDecoration(label: label, icon: icon, hinText: hinText),
      controller: controller,
      readOnly: readOnly,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
    );
  }

  static InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    required String hinText,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      filled: true,
      fillColor: Colors.grey.shade100,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF1E3C72), width: 1.5),
      ),
      hintText: hinText,
    );
  }
}
