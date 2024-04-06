import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/helper/supabase/supabase_helper.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';

part 'supplier_state.dart';

class SupplierCubit extends Cubit<SupplierState> {
  // SupplierCubit() : super(SupplierInitial(DatabaseHelper().getSuppliers()));
  SupplierCubit() : super(SupplierInitial(SupabaseHelper().getSuppliers()));

  void createSupplier(Supplier supplier) {
    //DatabaseHelper().createSupplier(supplier);
    SupabaseHelper().createSupplier(supplier);
    emit(SupplierUpdated(SupabaseHelper().getSuppliers()));
  }

  void updateSupplier(Supplier supplier) {
    SupabaseHelper().updateSupplier(supplier);
    emit(SupplierUpdated(SupabaseHelper().getSuppliers()));
  }

  void deleteSupplier(Supplier supplier) {
    DatabaseHelper().deleteSupplier(supplier);
    emit(SupplierUpdated(DatabaseHelper().getSuppliers()));
  }

  Future<void> searchSupplier(String searchString) async {
    final suppliers = await SupabaseHelper().getSuppliers();
    final filteredSuppliers = suppliers
        .where((supplier) =>
            supplier.name.toLowerCase().contains(searchString.toLowerCase()) ||
            supplier.city.toLowerCase().contains(searchString.toLowerCase()))
        .toList();

    emit(SupplierSearch(Future.value(filteredSuppliers)));
  }

  void findSupplier(int supplierId) {
    final suppliers = SupabaseHelper().findSupplier(supplierId);
    emit(SupplierFind(suppliers));
  }
}
