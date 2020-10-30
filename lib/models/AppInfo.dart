// To parse this JSON data, do
//
//     final appInfo = appInfoFromJson(jsonString);

import 'dart:convert';

import 'dart:typed_data';

AppInfo appInfoFromJson(String str) => AppInfo.fromJson(json.decode(str));

String appInfoToJson(AppInfo data) => json.encode(data.toJson());

class AppInfo {
 

    AppInfo({
        this.country,
        this.enable,
        this.name,
        this.packagename,
        this.type,
        this.versionName,
        this.icon,
    });

    String country;
    bool enable;
    String name;
    String packagename;
    String type;
    String versionName;
    Uint8List icon;

    factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
        country: json["country"] == null ? null : json["country"],
        enable: json["enable"] == null ? null : json["enable"],
        name: json["name"] == null ? null : json["name"],
        packagename: json["packagename"] == null ? null : json["packagename"],
        type: json["type"] == null ? null : json["type"],
    );

    Map<String, dynamic> toJson() => {
        "country": country == null ? null : country,
        "enable": enable == null ? null : enable,
        "name": name == null ? null : name,
        "packagename": packagename == null ? null : packagename,
        "type": type == null ? null : type,
    };
}
