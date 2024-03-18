import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';

part 'supplier_state.dart';

class SupplierCubit extends Cubit<SupplierState> {
  SupplierCubit() : super(SupplierInitial(DatabaseHelper().getSuppliers()));

  void createSupplier(Supplier supplier) {
    DatabaseHelper().createSupplier(supplier);
    emit(SupplierUpdated(DatabaseHelper().getSuppliers()));
  }

  void updateSupplier(Supplier supplier) {
    DatabaseHelper().updateSupplier(supplier);
    emit(SupplierUpdated(DatabaseHelper().getSuppliers()));
  }

  void deleteSupplier(Supplier supplier) {
    DatabaseHelper().deleteSupplier(supplier);
    emit(SupplierUpdated(DatabaseHelper().getSuppliers()));
  }

  Future<void> searchSupplier(String searchString) async {
    final suppliers = await DatabaseHelper().getSuppliers();
    final filteredSuppliers = suppliers
        .where((supplier) =>
            supplier.name.toLowerCase().contains(searchString.toLowerCase()) ||
            supplier.city.toLowerCase().contains(searchString.toLowerCase()))
        .toList();

    emit(SupplierSearch(Future.value(filteredSuppliers)));
  }
}
