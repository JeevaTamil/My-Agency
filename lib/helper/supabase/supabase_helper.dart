import 'package:my_agency/helper/supabase/tables.dart';
import 'package:my_agency/main.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';

class SupabaseHelper {
  static final SupabaseHelper _instance = SupabaseHelper.internal();
  factory SupabaseHelper() => _instance;
  SupabaseHelper.internal();

  Future<List<Supplier>> getSuppliers() async {
    final List<Map<String, dynamic>> maps =
        await supabase.from(SupabaseTables.suppliers).select();
    return List.generate(maps.length, (i) {
      return Supplier.fromMap(maps[i]);
    });
  }

  Future<void> createSupplier(Supplier supplier) async {
    final response =
        await supabase.from(SupabaseTables.suppliers).insert(supplier.toMap());
    if (response != null && response.error != null) {
      print('Error creating supplier: ${response.error!.message}');
    } else {
      print('Supplier created successfully');
    }
  }

  Future<void> updateSupplier(Supplier supplier) async {
    await supabase
        .from(SupabaseTables.suppliers)
        .update(supplier.toMap())
        .eq('supplier_id', supplier.supplierId!);
  }

  Future<void> createCustomer(Customer customer) async {
    final response =
        await supabase.from(SupabaseTables.customers).insert(customer.toMap());
    if (response != null && response.error != null) {
      print('Error creating customer: ${response.error!.message}');
    } else {
      print('Customer created successfully');
    }
  }

  Future<void> updateCustomer(Customer customer) async {
    await supabase
        .from(SupabaseTables.customers)
        .update(customer.toMap())
        .eq('customer_id', customer.customerId!);
  }

  Future<List<Customer>> getCustomers() async {
    final List<Map<String, dynamic>> maps =
        await supabase.from(SupabaseTables.customers).select();
    return List.generate(maps.length, (i) {
      return Customer.fromMap(maps[i]);
    });
  }
}
