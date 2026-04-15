import 'package:firebase_database/firebase_database.dart';
import 'package:latihanuts/models/data_narapidana.dart';

class DataService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref().child('data_narapidana');

  Stream<List<DataNarapidana>> getDataList(){
    return _databaseReference.onValue.map((event){
      final data = event.snapshot.value;
      if (data != null) {
        final Map<dynamic, dynamic> dataMap = data as Map<dynamic, dynamic>;
        return dataMap.entries.map((entry) {
          final key = entry.key.toString();
          final value = entry.value as Map<dynamic, dynamic>;
          return DataNarapidana.fromMap(key, value);
        }).toList();
      } else {
        return [];
      }

    });
  }
  Future addData(DataNarapidana data) async {
    await _databaseReference.push().set({
      'nama': data.nama,
      'jeniskelamin': data.jeniskelamin,
      'umur': data.umur,
      'kasus': data.kasus,
    });    
  } 

  Future deleteData(String key) async {
    await _databaseReference.child(key).remove();
  }  

}
