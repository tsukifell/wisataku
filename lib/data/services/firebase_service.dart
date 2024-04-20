import 'package:firebase_database/firebase_database.dart';

final DatabaseReference _database =
    FirebaseDatabase.instance.ref().child('wisataku');

Future<bool> addTourismPlace(
    String name, String location, double areaSize, String description) async {
  try {
    await _database.push().set({
      'name': name,
      'location': location,
      'areaSize': areaSize,
      'description': description
    });
    return true;
  } catch (e) {
    return false;
  }
}

Stream<Map<String, dynamic>> getTourismPlace() {
  return _database.onValue.map((event) {
    final Map<String, dynamic> places = {};
    DataSnapshot snapshot = event.snapshot;
    if (snapshot.value != null) {
      Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
      values.forEach((key, value) {
        places[key] = {
          'name': value['name'] as String,
          'location': value['location'] as String,
          'areaSize': value['areaSize'] as double,
          'description': value['description'] as String,
        };
      });
    }
    return places;
  });
}
