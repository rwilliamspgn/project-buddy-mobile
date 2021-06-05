import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class PInput extends StatelessWidget {
  final bool isEmail;
  final bool isPassword;
  final IconData? prefixIconData;
  final String label;
  final String? value;
  final Function(String)? onChanged;

  const PInput({
    Key? key,
    this.isEmail: false,
    this.isPassword: false,
    this.prefixIconData,
    required this.label,
    this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _hasError = false;
    String _value = this.value ?? '';

    if (this.isEmail && _value.length > 0) {
      if (!EmailValidator.validate(_value)) {
        _hasError = true;
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: TextEditingController()..text = _value,
          decoration: InputDecoration(
            prefixIcon: this.prefixIconData == null
                ? null
                : Icon(
                    this.prefixIconData,
                    size: 20.0,
                  ),
            // hintText: this.label,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: this.label,
            border: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: _hasError ? Colors.red : Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: _hasError ? Colors.red : Colors.grey),
            ),
            enabledBorder: _hasError
                ? UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 16.0),
          ),
          style: TextStyle(fontSize: 20.0),
          obscureText: this.isPassword,
          onChanged: (val) {
            this.onChanged!(val);
          },
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
