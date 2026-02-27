import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karyawan/models/karyawan.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<List<Karyawan>> masukKaryawan() async {
    final String response = await rootBundle.loadString("assets/karyawan.json");
    final dataKaryawan = jsonDecode(response);

    return List<Karyawan>.from(
      dataKaryawan.map((karyawan) => Karyawan.fromJson(karyawan)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: const Text("Daftar Karyawan"),
        ),
        body: FutureBuilder<List<Karyawan>>(
          future: masukKaryawan(),
          builder: (context, snapshot) {
            final daftarKaryawan = snapshot.data!;
            return ListView.builder(
              itemCount: daftarKaryawan.length,
              itemBuilder: (context, index) {
                final karyawan = daftarKaryawan[index];
                return ListTile(
                  title: Text(
                    karyawan.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Umur: ${karyawan.umur} tahun"),
                      Text(
                        "Alamat: ${karyawan.alamat.jalan}, ${karyawan.alamat.kota}, ${karyawan.alamat.provinsi}",
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
