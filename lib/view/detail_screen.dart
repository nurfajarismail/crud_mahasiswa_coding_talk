import 'package:crud_mahasiswa/response/res_get_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DetailScreen extends StatefulWidget {
  final DataMahasiswa? listMahasiswa;
  const DetailScreen(this.listMahasiswa, {super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Data"),
      ),
      body: ListView(children: [
        Text(
          "Nama : ${widget.listMahasiswa?.nama}",
          textAlign: TextAlign.center,
        ),
        Text(
          "NIM : ${widget.listMahasiswa?.nim}",
          textAlign: TextAlign.center,
        ),
        Text(
          "Jurusan : ${widget.listMahasiswa?.jurusan}",
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }
}
