part of 'supplier_cubit.dart';

@immutable
sealed class SupplierState {
  final Future<List<Supplier>> suppliers;

  const SupplierState(this.suppliers);
}

final class SupplierInitial extends SupplierState {
  const SupplierInitial(super.suppliers);
}

final class SupplierUpdated extends SupplierState {
  const SupplierUpdated(super.suppliers);
}

final class SupplierSearch extends SupplierState {
  const SupplierSearch(super.suppliers);
}

final class SupplierFind extends SupplierState {
  const SupplierFind(super.suppliers);
}
