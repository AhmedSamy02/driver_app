import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormField extends StatefulWidget {
  const LoginFormField({
    super.key,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    required this.controller,
    required this.textInputAction,
  });
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final TextInputAction textInputAction;
  @override
  State<LoginFormField> createState() => _LoginFormFieldState();
}

class _LoginFormFieldState extends State<LoginFormField> {
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
    if (!obscureText) {
      passField = false;
    } else {
      passField = true;
    }
  }

  bool obscureText = false;
  bool passField = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        suffixIcon: passField
            ? IconButton(
                onPressed: () {
                  obscureText = !obscureText;
                  setState(() {});
                },
                icon: FaIcon(obscureText
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
                iconSize: 22,
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: Colors.white),
        ),
        filled: true,
        hintStyle: const TextStyle(color: Colors.grey),
        hintText: widget.hintText,
        fillColor: Colors.white,
      ),
      obscureText: obscureText,
      cursorColor: Colors.blue[900],
      maxLines: 1,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
      ),
    );
  }
}
