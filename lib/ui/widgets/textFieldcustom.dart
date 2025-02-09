import 'package:flutter/material.dart';

class Textfieldcustom extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final IconData? icon;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;

  const Textfieldcustom({
    this.controller,
    this.hintText = '',
    this.icon,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      onTap: onTap,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon != null ? Icon(icon, color: Colors.redAccent) : null,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
    );
  }
}
