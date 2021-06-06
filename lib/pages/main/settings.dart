import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';
import 'package:project_buddy_mobile/services/helper.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FractionallySizedBox(
              widthFactor: 0.2,
              child: Image.asset(Assets.assetsLogo),
            ),
            SizedBox(height: 16.0),
            _Button(
              title: 'Profile',
              onTap: () {},
            ),
            _Button(
              title: 'Change Password',
              onTap: () {},
            ),
            _Button(
              title: 'Terms and Conditions',
              onTap: () {},
            ),
            _Button(
              title: 'Logout',
              onTap: () {
                Helper.token = '';
                Goto.root('/');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _Button({required String title, Function()? onTap}) {
    return Card(
      shape: RoundedRectangleBorder(),
      child: ListTile(
        onTap: onTap!,
        title: Text(title),
        trailing: Icon(Icons.chevron_right),
      ),
    );
  }
}
