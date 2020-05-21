import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_agency/models/purchase_entry_model.dart';

class PurchaseEntryServices {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('purchase entry');

  Stream streamPurchaseEntries() {
    var purchaseEntries = _collectionReference.snapshots();
    return purchaseEntries;
  }

  //add purchase entry data
  Future addPurchaseEntry(PurchaseEntryModel entryModel) async {
    try {
      await _collectionReference.add(entryModel.toMap()).then((value) {
        print("purchase entry data added");
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete
  Future deletePurchaseEntry(DocumentSnapshot snapshot) async {
    try {
      await _collectionReference.document(snapshot.documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
