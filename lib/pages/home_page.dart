import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:swadeshiapp/pages/scan_apps_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      // appBar: AppBar(
      //   // title: Text('Remove china products'),
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              height: 40,
              color: Colors.orange,
              minWidth: double.infinity,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanAppPage())),
              child: Text(
                'Scan Installed Apps',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              height: 40,
              color: Colors.white,
              minWidth: double.infinity,
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanAppPage())),
              child: Text(
                'Check Alternatives ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              height: 40,
              color: Colors.green,
              minWidth: double.infinity,
              onPressed: () async {
                String cameraScanResult = await scanner.scan();
                print('mas is' + cameraScanResult);
              },
              child: Text(
                'Scan QR',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
