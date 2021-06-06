import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/services/helper.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    _formData = Helper.fillForm(
        formKey: 'loginForm', fields: {'email': '', 'password': ''});
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
                            '${Helper.routeExtension.toUpperCase()} Login',
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
                              label: 'Email Address',
                              prefixIconData: Icons.email_outlined,
                              isEmail: true,
                              value: _formData['email'],
                              onChanged: (val) {
                                _formData['email'] = val;
                              },
                            ),
                            PInput(
                              label: 'Password',
                              prefixIconData: Icons.vpn_key_outlined,
                              isPassword: true,
                              value: _formData['password'],
                              onChanged: (val) {
                                _formData['password'] = val;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Goto.push('/forgot-password');
                                  },
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.0),
                            PButton(
                              label: 'Login',
                              full: true,
                              onTap: () {
                                Helper.token = 'sample-token';
                                Goto.root('/my-schedules');
                              },
                            ),
                            SizedBox(height: 16.0),
                            InkWell(
                              onTap: () {
                                Goto.transfer(
                                    '/register/${Helper.routeExtension}');
                              },
                              child: Text(
                                'Register',
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
