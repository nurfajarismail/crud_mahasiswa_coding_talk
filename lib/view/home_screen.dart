import 'package:crud_mahasiswa/network/api.dart';
import 'package:crud_mahasiswa/response/res_add_data.dart';
import 'package:crud_mahasiswa/response/res_edit_data.dart';
import 'package:crud_mahasiswa/response/res_get_data.dart';
import 'package:crud_mahasiswa/view/add_screen.dart';
import 'package:crud_mahasiswa/view/detail_screen.dart';
import 'package:crud_mahasiswa/view/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  List<DataMahasiswa> listMahasiswa = [];
  Future<ResGetMahasiswa?> getMahasiswa() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response =
          await http.get(Uri.parse("${baseUrl}get_data.php"));
      List<DataMahasiswa>? data = resGetMahasiswaFromJson(response.body).data;
      setState(() {
        isLoading = false;
        listMahasiswa = data ?? [];
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      });
    }
    return null;
  }

  Future<ResAddMahasiswa?> deleteMahasiswa(String id) async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response = await http.post(
          Uri.parse(
            "${baseUrl}delete_data.php",
          ),
          body: {"id": id});
      ResAddMahasiswa data = resAddMahasiswaFromJson(response.body);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      });
    }
    return null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMahasiswa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Homepage")),
      body: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                  title: Text("${listMahasiswa[index].nama}"),
                  subtitle: Text("${listMahasiswa[index].jurusan}"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                DetailScreen(listMahasiswa[index])));
                  },
                  trailing: Container(
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          EditScreen(listMahasiswa[index])));
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () async {
                              await showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('Konfirmasi Penghapusan'),
                                  content: const Text(
                                      'Apakah anda yakin ingin menghapus data ini?'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Tidak'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await deleteMahasiswa(
                                            listMahasiswa[index].id.toString());
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                ),
                              );
                              getMahasiswa();
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          )
                        ]),
                  )),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddScreen()));
        }),
        child: Icon(Icons.add),
      ),
    );
  }
}
