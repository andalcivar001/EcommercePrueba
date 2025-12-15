import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  String label;
  IconData icon;
  TextInputType textInputType;
  bool obscureText = false;
  String? initialValue;
  Function(String)? onChanged;
  String? Function(String?)? validator;

  DefaultTextField({
    Key? key,
    required this.label,
    required this.icon,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    this.initialValue,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      initialValue: initialValue,
      onChanged: (text) {
        onChanged!(text);
      },
      keyboardType: textInputType,
      validator: validator,
      decoration: _inputDecoration(label: label, icon: icon),
    );
  }

  static InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
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
    );
  }
}
