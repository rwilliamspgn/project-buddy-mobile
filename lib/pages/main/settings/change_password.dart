import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/services/helper.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    _formData = Helper.fillForm(formKey: 'changePasswordForm', fields: {
      'current_password': '',
      'password': '',
      'password_confirmation': '',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              PInput(
                label: 'Current Password',
                prefixIconData: Icons.vpn_key,
                isPassword: true,
                value: _formData['current_password'],
                onChanged: (val) {
                  _formData['current_password'] = val;
                },
              ),
              Divider(),
              PInput(
                label: 'Password',
                prefixIconData: Icons.vpn_key_outlined,
                isPassword: true,
                value: _formData['password'],
                onChanged: (val) {
                  _formData['password'] = val;
                },
              ),
              PInput(
                label: 'Password Confirmation',
                prefixIconData: Icons.vpn_key_outlined,
                isPassword: true,
                value: _formData['password_confirmation'],
                onChanged: (val) {
                  _formData['password_confirmation'] = val;
                },
              ),
              SizedBox(height: 16.0),
              PButton(
                label: 'Change',
                full: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
