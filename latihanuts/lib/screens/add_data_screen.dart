import 'package:flutter/material.dart';
import 'package:latihanuts/models/data_narapidana.dart';
import 'package:latihanuts/services/data_service.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({super.key});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final _formKey = GlobalKey<FormState>();
  final DataService dataService = DataService();

  String nama = '';
  int jenisKelamin = 1;
  int umur = 0;
  String kasus = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Narapidana'),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Field Nama
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    hintText: 'Masukkan nama narapidana',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    nama = value;
                  },
                ),
                const SizedBox(height: 16),

                // Field Jenis Kelamin
                DropdownButtonFormField<int>(
                  value: jenisKelamin,
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.wc),
                  ),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('Laki-laki')),
                    DropdownMenuItem(value: 2, child: Text('Perempuan')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value ?? 1;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Field Umur
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Umur',
                    hintText: 'Masukkan umur',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.calendar_today),
                    suffixText: 'tahun',
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Umur tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Umur harus berupa angka';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    umur = int.tryParse(value) ?? 0;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Kasus',
                    hintText: 'Masukkan jenis kasus',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.description),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kasus tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    kasus = value;
                  },
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: isLoading ? null : _saveData,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Simpan Data',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveData() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final newData = DataNarapidana(
          key: '',
          nama: nama,
          jeniskelamin: jenisKelamin,
          umur: umur,
          kasus: kasus,
        );

        await dataService.addData(newData);

        if (mounted) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Data berhasil disimpan'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
