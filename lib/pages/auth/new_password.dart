import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  _NewPasswordPageState createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  Map<String, dynamic> _formData = {
    'password': '',
    'password_confirmation': ''
  };

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
                            'Set New Password',
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
                              label: 'Set Password',
                              full: true,
                              onTap: () {
                                Goto.root('/');
                              },
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
