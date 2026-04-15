class DataNarapidana {
  final String key;
  final String nama;
  final int jeniskelamin;
  final int umur;
  final String kasus;

  DataNarapidana({
    required this.key,
    required this.nama,
    required this.jeniskelamin,
    required this.umur,
    required this.kasus,
  });

  factory DataNarapidana.fromMap(String key, Map<dynamic, dynamic> json) {
    return DataNarapidana(
      key: key,
      nama: json['nama'].toString(),
      jeniskelamin: json['jeniskelamin'],
      umur: json['umur'] ?? 0,
      kasus: json['kasus'].toString(),
    );
  }
}