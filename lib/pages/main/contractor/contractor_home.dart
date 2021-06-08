import 'package:flutter/material.dart';
import 'package:project_buddy_mobile/env/config.dart';
import 'package:project_buddy_mobile/services/goto.dart';

class ContractorHomePage extends StatefulWidget {
  const ContractorHomePage({Key? key}) : super(key: key);

  @override
  _ContractorHomePageState createState() => _ContractorHomePageState();
}

class _ContractorHomePageState extends State<ContractorHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Schedules'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Goto.push('/settings');
            },
            icon: Icon(Icons.settings),
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Jobs',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              constraints: BoxConstraints(
                maxHeight: 200.0,
              ),
              color: Config.primaryColor.withOpacity(0.1),
              child: Text('No Jobs yet'),
              // child: ListView(
              //   shrinkWrap: true,
              //   children: [
              //     _JobItem('First task', 'No Update'),
              //     _JobItem('Second task', 'No Update'),
              //     _JobItem('Third task', 'No Update'),
              //   ],
              // ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  ListTile _JobItem(String name, String status) {
    return ListTile(
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: TextStyle(color: Colors.red),
          ),
          Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
