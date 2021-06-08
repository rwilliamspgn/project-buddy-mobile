import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/models/auth_model.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/services/helper.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    _formData = Helper.fillForm(formKey: 'loginForm', fields: {
      'role': Helper.routeExtension,
      'name': '',
      'email': '',
      'password': '',
      'password_confirmation': '',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                Container(
                  constraints: BoxConstraints(
                    minHeight: size.height - 16.0,
                    minWidth: size.width,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FractionallySizedBox(
                            widthFactor: 0.2,
                            child: Image.asset(Assets.assetsLogo),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            '${Helper.routeExtension.toUpperCase()} '
                            'Registration',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          children: [
                            PInput(
                              label: 'Name',
                              prefixIconData: Icons.account_circle_outlined,
                              value: _formData['name'],
                              onChanged: (val) {
                                _formData['name'] = val;
                              },
                            ),
                            PInput(
                              label: 'Email Address',
                              prefixIconData: Icons.email_outlined,
                              isEmail: true,
                              value: _formData['email'],
                              onChanged: (val) {
                                _formData['email'] = val;
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
                              label: 'Register',
                              full: true,
                              onTap: () async {
                                bool res = await AuthModel.register(_formData);
                                if (res) {
                                  Helper.globalBox
                                      .put('fromAction', 'registration');
                                  Goto.push('/token-input');
                                }
                              },
                            ),
                            SizedBox(height: 16.0),
                            InkWell(
                              onTap: () {
                                Goto.transfer(
                                    '/login/${Helper.routeExtension}');
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Need help?',
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Goto.transfer('/');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
