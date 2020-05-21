import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_agency/models/supplier_model.dart';

class SuppliersServices {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('suppliers');

  Stream streamSuppliers() {
    var suppliers = _collectionReference.snapshots();
    return suppliers;
  }

  //add Supplier data
  Future addSupplier(SuppliersModel supplier) async {
    try {
      await _collectionReference.add(supplier.toMap()).then((value) {
        print("supplier data added");
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete
  Future deleteSupplier(DocumentSnapshot snapshot) async {
    try {
      await _collectionReference.document(snapshot.documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future getSupplierWithId(String documentID) async {
    DocumentReference ref = _collectionReference.document(documentID);
    return ref.get();
  }

  // search by name
  Stream searchByName(String value) {
    return _collectionReference
        .where('search_key', isEqualTo: value.substring(0, 1).toUpperCase())
        .getDocuments()
        .asStream();
  }
}
