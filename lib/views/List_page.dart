// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_uas/database/dbhelper.dart';
import 'package:flutter_uas/models/biodata.dart';
import 'package:flutter_uas/views/Detail_page.dart';
import 'package:flutter_uas/views/Form_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);
  // const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List<Biodata> listBiodata = [];
  DbHelper db = DbHelper();

  //mengambil semua data Biodata
  Future<void> _getAllBiodata() async {
    //list menampung data dari database
    var list = await db.getAllBiodata();

    //ada perubahanan state
    setState(
      () {
        //hapus data pada listBiodata
        listBiodata.clear();

        //lakukan perulangan pada variabel list
        for (var biodata in list!) {
          //masukan data ke listBiodata
          listBiodata.add(
            Biodata.fromMap(biodata),
          );
        }
      },
    );
  }

  //menghapus data Biodata
  Future<void> _deleteBiodata(Biodata biodata, int position) async {
    await db.deleteBiodata(biodata.id!);
    setState(() {
      listBiodata.removeAt(position);
    });
  }

  // membuka halaman tambah Biodata
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FormPage(),
      ),
    );
    if (result == 'save') {
      await _getAllBiodata();
    }
  }

  //membuka halaman edit Biodata
  Future<void> _openFormEdit(Biodata biodata) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormPage(biodata: biodata),
      ),
    );
    if (result == 'update') {
      await _getAllBiodata();
    }
  }

  // membuka halaman detail Biodata
  Future<void> _openFormDetail(Biodata biodata) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(biodata: biodata),
      ),
    );
    if (result == 'show') {
      await _getAllBiodata();
    }
  }

  @override
  void initState() {
    //menjalankan fungsi getallbiodata saat pertama kali dimuat
    _getAllBiodata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("List Biodata : ${listBiodata.length} Data"),
        ),
      ),
      body: ListView.builder(
        itemCount: listBiodata.length,
        itemBuilder: (context, index) {
          Biodata biodata = listBiodata[index];
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListTile(
              leading: const Icon(
                Icons.person,
                size: 50,
              ),
              title: Text('${biodata.name}'),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text("Alamat: ${biodata.alamat}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text("NIM: ${biodata.nim}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text("Jenis Kelamin: ${biodata.jenisKelamin}"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text("Tanggal Lahir: ${biodata.date}"),
                  ),
                ],
              ),
              trailing: FittedBox(
                fit: BoxFit.fill,
                child: Row(
                  children: [
                    //button detail
                    IconButton(
                      onPressed: () {
                        _openFormDetail(biodata);
                      },
                      icon: const Icon(Icons.remove_red_eye),
                    ),
                    // button edit
                    IconButton(
                      onPressed: () {
                        _openFormEdit(biodata);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    // button hapus
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        //membuat dialog konfirmasi hapus
                        AlertDialog hapus = AlertDialog(
                          title: const Text("Information"),
                          content: SizedBox(
                            height: 100,
                            child: Column(
                              children: [
                                Text(
                                  "Yakin ingin Menghapus Data ${biodata.name}",
                                )
                              ],
                            ),
                          ),
                          //terdapat 2 button.
                          //jika ya maka jalankan _deleteBiodata() dan tutup dialog
                          //jika tidak maka tutup dialog
                          actions: [
                            TextButton(
                              onPressed: () {
                                _deleteBiodata(biodata, index);
                                Navigator.pop(context);
                              },
                              child: const Text("Ya"),
                            ),
                            TextButton(
                              child: const Text('Tidak'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                        showDialog(
                            context: context, builder: (context) => hapus);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }
}
