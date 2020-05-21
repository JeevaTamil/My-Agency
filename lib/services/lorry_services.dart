import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_agency/models/Lorry_model.dart';

class LorryServices {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('lorry');

  Stream streamLorrys() {
    var lorrys = _collectionReference.snapshots();
    return lorrys;
  }

  //add Lorry data
  Future addLorry(LorryModel lorry) async {
    try {
      await _collectionReference.add(lorry.toMap()).then((value) {
        print("Lorry data added");
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete
  Future deleteLorry(DocumentSnapshot snapshot) async {
    try {
      await _collectionReference.document(snapshot.documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
