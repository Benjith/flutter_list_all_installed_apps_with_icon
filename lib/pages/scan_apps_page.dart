import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swadeshiapp/models/AppInfo.dart';

class ScanAppPage extends StatefulWidget {
  @override
  _ScanAppPageState createState() => _ScanAppPageState();
}

class _ScanAppPageState extends State<ScanAppPage> {
  // List<AppInfo> _allApps = List<AppInfo>();
  static const platform =
      const MethodChannel('com.ekalavya.swadeshiapp/uninstall');
  List<ApplicationWithIcon> _installedApps = <ApplicationWithIcon>[];
  _startScan() async {
    // QuerySnapshot data = await Firestore.instance
    //     .collection('appnames')
    //     .where('country', isEqualTo: 'zh')
    //     .getDocuments();
    // if (data.documents.isNotEmpty) {}
    // print(data.documents.first.data);
    List<Application> apps = await DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: false,
        includeAppIcons: true);

    if (apps.isNotEmpty) {
      setState(() {
        // _installedApps = apps;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text('Scan Apps'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: FutureBuilder(
          future: DeviceApps.getInstalledApplications(
              includeAppIcons: true,
              includeSystemApps: false,
              onlyAppsWithLaunchIntent: true),
          builder: (context, data) {
            if (data.data == null) {
              return Center(child: CircularProgressIndicator());
            } else {
              List<AppInfo> _apps = List<AppInfo>();
              for (Application item in data.data) {
                _apps.add(AppInfo(
                    name: item.appName,
                    country: 'Unknown',
                    packagename: item.packageName,
                    versionName: item.versionName,
                    icon: item is ApplicationWithIcon ? item.icon : null));
              }

              return ListView.builder(
                  itemBuilder: (context, position) {
                    AppInfo app = _apps[position];
                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: app.icon != null
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(app.icon),
                                  // backgroundColor: Colors.blue,
                                )
                              : null,
                          trailing: Flag(
                            "IN",
                            height: 30,
                            width: 40,
                          ),
                          // onTap: () => DeviceApps.openApp(app.packageName),
                          title: Text("${app.name} (${app.packagename})"),
                          subtitle: Text('Version: ${app.versionName}'),
                        ),
                        Divider(
                          height: 1.0,
                        )
                      ],
                    );
                  },
                  itemCount: _apps.length);
            }
          }),
      // ListView.builder(
      //     itemCount: _installedApps.length,
      //     itemBuilder: (context, i) {
      //       return Theme(
      //         data: ThemeData.dark(),
      //         child: Container(
      //           margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      //           color: Colors.blue,
      //           child: ListTile(
      //             leading: Image.memory(_installedApps[i].icon),
      //             trailing: Flag(
      //               'in',
      //               fit: BoxFit.fill,
      //               height: 40.0,
      //               width: 60.0,
      //             ),
      //             subtitle: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 Text(_installedApps[i].versionName),
      //                 Flexible(child: Text(_installedApps[i].packageName)),
      //               ],
      //             ),
      //             title: Text(_installedApps[i].appName),
      //           ),
      //         ),
      //       );
      //     }),
    );
  }
}
