import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  Future addDetails(Map<String, dynamic> detailsMap, String Id) async {
    return await FirebaseFirestore.instance
        .collection("Employee")
        .doc(Id)
        .set(detailsMap);
  }
  Future<Stream<QuerySnapshot>> getDetails() async{
    return await FirebaseFirestore.instance.collection("Employee").snapshots();
  }
  Future updateDetail(String id,Map<String,dynamic> map) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).update(map);

  }
  Future deleteDetail(String id) async{
    return await FirebaseFirestore.instance.collection("Employee").doc(id).delete();

  }
}
