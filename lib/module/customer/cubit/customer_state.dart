part of 'customer_cubit.dart';

@immutable
sealed class CustomerState {
  final Future<List<Customer>> customers;

  const CustomerState(this.customers);
}

final class CustomerInitial extends CustomerState {
  const CustomerInitial(super.customers);
}

final class CustomerUpdated extends CustomerState {
  const CustomerUpdated(super.customers);
}

final class CustomerSearch extends CustomerState {
  const CustomerSearch(super.customers);
}