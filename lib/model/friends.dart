import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
  String? name;
  String? description;
  int? idnumber;
  String? position;
  String? profile;
  Timestamp? time;

  Friends({
    required this.name,
    this.description,
    this.idnumber,
    this.position,
    this.profile,
    this.time,
  });

  factory Friends.fromMap(Map<String, dynamic> map) {
    return Friends(
      name: map['name'],
      description: map['description'],
      idnumber: map['idnumber'],
      position: map['position'],
      profile: map['profile'],
      time: map['timeAdded'],
    );
  }

  static Stream<List<Friends>> fetchStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .orderBy('timeAdded', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Friends.fromMap(doc.data())).toList());
  }

  static addFriend({
    required String name,
    required String description,
    required int idNumber,
    required String position,
    required String profile,
  }) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'description': description,
      'idnumber': idNumber,
      'position': position,
      'profile': profile,
      'timeAdded': FieldValue.serverTimestamp(),
    });
  }
}
