import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/services/helper.dart';
import 'package:project_buddy_mobile/widgets/p_button.dart';
import 'package:project_buddy_mobile/widgets/p_input.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> _formData = {};

  @override
  void initState() {
    _formData = Helper.fillForm(formKey: 'profileForm', fields: {
      'name': '',
      'email': '',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 16.0),
              PButton(
                label: 'Update',
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
