import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_agency/models/customer_model.dart';

class CustomersServices {
  //final _fireStoreInstance = Firestore.instance;
  final CollectionReference _collectionReference =
      Firestore.instance.collection('customers');

  Stream streamCustomers() {
    var customers = _collectionReference.snapshots();
    return customers;
  }

  //add Customer data
  Future addCustomer(CustomersModel customer) async {
    try {
      await _collectionReference.add(customer.toMap()).then((value) {
        print("customer data added");
        print(value.documentID);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  // delete
  Future deleteCustomer(DocumentSnapshot snapshot) async {
    try {
      await _collectionReference.document(snapshot.documentID).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
