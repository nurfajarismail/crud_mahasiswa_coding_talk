import 'package:crud_mahasiswa/network/api.dart';
import 'package:crud_mahasiswa/response/res_add_data.dart';
import 'package:crud_mahasiswa/response/res_edit_data.dart';
import 'package:crud_mahasiswa/response/res_get_data.dart';
import 'package:crud_mahasiswa/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditScreen extends StatefulWidget {
  final DataMahasiswa listMahasiswa;
  const EditScreen(this.listMahasiswa, {super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController controllerNama = TextEditingController();
  TextEditingController controllerNim = TextEditingController();
  TextEditingController controllerJurusan = TextEditingController();
  bool isLoading = false;

  Future<ResEditData?> editMahasiswa() async {
    try {
      setState(() {
        isLoading = true;
      });

      var response =
          await http.post(Uri.parse('${baseUrl}edit_data.php'), body: {
        "id": widget.listMahasiswa.id,
        "nama": controllerNama.text,
        "nim": controllerNim.text,
        "jurusan": controllerJurusan.text
      });

      ResEditData data = resEditDataFromJson(response.body);
      if (data.value == 1) {
        isLoading = false;
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
      } else {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerNama = TextEditingController(text: widget.listMahasiswa.nama);
    controllerNim = TextEditingController(text: widget.listMahasiswa.nim);
    controllerJurusan =
        TextEditingController(text: widget.listMahasiswa.jurusan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Data")),
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
                  editMahasiswa();
                },
                child: Text("UPDATE"))
          ],
        ),
      ),
    );
  }
}
