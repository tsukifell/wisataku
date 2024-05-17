import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<bool> addTourismPlace(
    String name, String location, double areaSize, String description) async {
  try {
    await _firestore.collection('wisataku').add({
      'name': name,
      'location': location,
      'areaSize': areaSize,
      'description': description,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Stream<Map<String, dynamic>> getTourismPlace() {
  return _firestore.collection('wisataku').snapshots().map((snapshot) {
    final Map<String, dynamic> places = {};
    for (var doc in snapshot.docs) {
      places[doc.id] = {
        'name': doc['name'] as String,
        'location': doc['location'] as String,
        'areaSize': doc['areaSize'] as double,
        'description': doc['description'] as String,
      };
    }
    return places;
  });
}
