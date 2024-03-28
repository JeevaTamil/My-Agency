import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/helper/supabase/supabase_helper.dart';
import 'package:my_agency/module/customer/model/customer.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial(SupabaseHelper().getCustomers()));

  void createCustomer(Customer customer) {
    SupabaseHelper().createCustomer(customer);
    emit(CustomerUpdated(SupabaseHelper().getCustomers()));
  }

  void updateCustomer(Customer customer) {
    SupabaseHelper().updateCustomer(customer);
    emit(CustomerUpdated(SupabaseHelper().getCustomers()));
  }

  void deleteCustomer(Customer customer) {
    DatabaseHelper().deleteCustomer(customer);
    emit(CustomerUpdated(DatabaseHelper().getCustomers()));
  }

  Future<void> searchCustomer(String searchString) async {
    final customers = await SupabaseHelper().getCustomers();
    final filteredCustomers = customers
        .where((customer) =>
            customer.name.toLowerCase().contains(searchString.toLowerCase()) ||
            customer.city.toLowerCase().contains(searchString.toLowerCase()))
        .toList();

    emit(CustomerSearch(Future.value(filteredCustomers)));
  }
}
