import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_agency/models/bank_model.dart';

class BankServices {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('banks');

  Stream streamBanks() {
    var banks = _collectionReference.snapshots();
    return banks;
  }

  //add Bank data
  Future addBank(BankModel bank) async {
    try {
      await _collectionReference.add(bank.toMap()).then((value) {
        print("bank data added");
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete
  Future deleteBank(DocumentSnapshot snapshot) async {
    try {
      await _collectionReference.document(snapshot.documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
