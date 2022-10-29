// To parse this JSON data, do
//
//     final resEditData = resEditDataFromJson(jsonString);

import 'dart:convert';

ResEditData resEditDataFromJson(String str) =>
    ResEditData.fromJson(json.decode(str));

String resEditDataToJson(ResEditData data) => json.encode(data.toJson());

class ResEditData {
  ResEditData({
    this.value,
    this.message,

    
  });

  int? value;
  String? message;

  factory ResEditData.fromJson(Map<String, dynamic> json) => ResEditData(
        value: json["value"] == null ? null : json["value"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "message": message == null ? null : message,
      };
}
