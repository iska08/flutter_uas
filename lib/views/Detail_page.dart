// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_uas/models/biodata.dart';
import 'package:flutter_uas/views/List_page.dart';

class DetailPage extends StatefulWidget {
  final Biodata biodata;
  const DetailPage({
    Key? key,
    required this.biodata,
  }) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Detail Biodata"),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 50,
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://as2.ftcdn.net/v2/jpg/03/49/49/79/1000_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.jpg',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                      border: Border.all(
                        color: Colors.lightBlue,
                        width: 3,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    margin: const EdgeInsets.only(bottom: 30),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Nim : ${widget.biodata.nim!}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Nama : ${widget.biodata.name!}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Alamat : ${widget.biodata.alamat!}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Jenis kelamin : ${widget.biodata.jenisKelamin!}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Text(
                  "Tanggal Lahir : ${widget.biodata.date!}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ListPage();
                },
              ),
            );
          },
          child: const Icon(Icons.keyboard_arrow_left),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
