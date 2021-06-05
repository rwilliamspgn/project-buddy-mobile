import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String _email = '';

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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                            'Forgot Password',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          children: [
                            PInput(
                              label: 'Email Address',
                              prefixIconData: Icons.email_outlined,
                              isEmail: true,
                              value: _email,
                              onChanged: (val) {
                                _email = val;
                              },
                            ),
                            Text('Enter email for confirmation'),
                            SizedBox(height: 24.0),
                            PButton(
                              label: 'Confirm',
                              full: true,
                              onTap: () {},
                            ),
                          ],
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
                        Goto.back();
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
