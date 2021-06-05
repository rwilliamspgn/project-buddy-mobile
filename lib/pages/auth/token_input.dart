import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:project_buddy_mobile/env/config.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';

class TokenInputPage extends StatefulWidget {
  const TokenInputPage({Key? key}) : super(key: key);

  @override
  _TokenInputPageState createState() => _TokenInputPageState();
}

class _TokenInputPageState extends State<TokenInputPage> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Config.primaryColor),
    );
  }

  String _pin = '';

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
                            'Verification',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          children: [
                            Text('Input token to verify'),
                            SizedBox(height: 16.0),
                            PinPut(
                              fieldsCount: 6,
                              checkClipboard: true,
                              onChanged: (pin) {
                                setState(() {
                                  _pin = pin;
                                });
                              },
                              eachFieldHeight: 32.0,
                              textStyle: TextStyle(fontSize: 24.0),
                              focusNode: _pinPutFocusNode,
                              controller: _pinPutController,
                              submittedFieldDecoration: _pinPutDecoration,
                              selectedFieldDecoration: _pinPutDecoration,
                              followingFieldDecoration: _pinPutDecoration,
                            ),
                            SizedBox(height: 16.0),
                            PButton(
                              label: 'Verify',
                              full: true,
                              onTap: _pin.length < 6
                                  ? null
                                  : () {
                                      // TODO: parameter for registration or
                                      //  change password
                                      Goto.transfer('/set-new-password');
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
