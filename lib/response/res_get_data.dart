// To parse this JSON data, do
//
//     final resGetMahasiswa = resGetMahasiswaFromJson(jsonString);

import 'dart:convert';

ResGetMahasiswa resGetMahasiswaFromJson(String str) =>
    ResGetMahasiswa.fromJson(json.decode(str));

String resGetMahasiswaToJson(ResGetMahasiswa data) =>
    json.encode(data.toJson());

class ResGetMahasiswa {
  ResGetMahasiswa({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<DataMahasiswa>? data;

  factory ResGetMahasiswa.fromJson(Map<String, dynamic> json) =>
      ResGetMahasiswa(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataMahasiswa>.from(
                json["data"].map((x) => DataMahasiswa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataMahasiswa {
  DataMahasiswa({
    this.id,
    this.nama,
    this.nim,
    this.jurusan,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? nama;
  String? nim;
  String? jurusan;
  String? createdAt;
  String? updatedAt;

  factory DataMahasiswa.fromJson(Map<String, dynamic> json) => DataMahasiswa(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        nim: json["nim"] == null ? null : json["nim"],
        jurusan: json["jurusan"] == null ? null : json["jurusan"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama": nama == null ? null : nama,
        "nim": nim == null ? null : nim,
        "jurusan": jurusan == null ? null : jurusan,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
