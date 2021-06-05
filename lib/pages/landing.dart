import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/env/config.dart';
import 'package:project_buddy_mobile/generated/assets.dart';
import 'package:project_buddy_mobile/services/goto.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(
          minHeight: size.height,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FractionallySizedBox(
                widthFactor: 0.3,
                child: Image.asset(Assets.assetsLogo),
              ),
              SizedBox(height: 16.0),
              Text(
                'Welcome to ${Config.appName}',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 24.0),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Card(
                  shape: RoundedRectangleBorder(),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Goto.push('/login/client');
                        },
                        selected: true,
                        title: Text(
                          'Client',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Config.primaryColor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Goto.push('/login/contractor');
                        },
                        selected: true,
                        title: Text(
                          'Contractor',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Config.primaryColor,
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Goto.push('/login/buddy');
                        },
                        selected: true,
                        title: Text(
                          'Project Buddy',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: Icon(
                          Icons.arrow_right,
                          color: Config.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
