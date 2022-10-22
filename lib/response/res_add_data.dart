// To parse this JSON data, do
//
//     final resAddMahasiswa = resAddMahasiswaFromJson(jsonString);

import 'dart:convert';

ResAddMahasiswa resAddMahasiswaFromJson(String str) =>
    ResAddMahasiswa.fromJson(json.decode(str));

String resAddMahasiswaToJson(ResAddMahasiswa data) =>
    json.encode(data.toJson());

class ResAddMahasiswa {
  ResAddMahasiswa({
    this.value,
    this.message,
  });

  int? value;
  String? message;

  factory ResAddMahasiswa.fromJson(Map<String, dynamic> json) =>
      ResAddMahasiswa(
        value: json["value"] == null ? null : json["value"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "value": value == null ? null : value,
        "message": message == null ? null : message,
      };
}
