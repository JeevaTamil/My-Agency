import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database_helper.dart';
import 'package:my_agency/module/customer/model/customer.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerInitial(DatabaseHelper().getCustomers()));

  void createCustomer(Customer customer) {
    DatabaseHelper().createCustomer(customer);
    emit(CustomerUpdated(DatabaseHelper().getCustomers()));
  }

  void updateCustomer(Customer customer) {
    DatabaseHelper().updateCustomer(customer);
    emit(CustomerUpdated(DatabaseHelper().getCustomers()));
  }

  void deleteCustomer(Customer customer) {
    DatabaseHelper().deleteCustomer(customer);
    emit(CustomerUpdated(DatabaseHelper().getCustomers()));
  }
}
