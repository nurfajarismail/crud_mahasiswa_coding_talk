import 'package:crud_mahasiswa/network/api.dart';
import 'package:crud_mahasiswa/response/res_add_data.dart';
import 'package:crud_mahasiswa/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNim = TextEditingController();
  TextEditingController controllerJurusan = TextEditingController();
  bool isLoading = false;

  Future<ResAddMahasiswa?> addMahasiswa() async {
    try {
      setState(() {
        isLoading = true;
      });

      var response =
          await http.post(Uri.parse('${baseUrl}add_data.php'), body: {
        "nama": controllerNama.text,
        "nim": controllerNim.text,
        "jurusan": controllerJurusan.text
      });

      ResAddMahasiswa data = resAddMahasiswaFromJson(response.body);
      if (data.value == 1) {
        isLoading = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else if (data.value == 2) {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data.message.toString(),
            ),
          ),
        );
      }
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tambah Data")),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TextFormField(
              controller: controllerNama,
              decoration: InputDecoration(label: Text("Nama")),
            ),
            TextFormField(
              controller: controllerNim,
              decoration: InputDecoration(label: Text("NIM")),
            ),
            TextFormField(
              controller: controllerJurusan,
              decoration: InputDecoration(label: Text("Jurusan")),
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () {
                  addMahasiswa();
                },
                child: Text("SUBMIT"))
          ],
        ),
      ),
    );
  }
}
