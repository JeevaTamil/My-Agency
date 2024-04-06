import 'package:my_agency/helper/supabase/tables.dart';
import 'package:my_agency/helper/utils/util_methods.dart';
import 'package:my_agency/main.dart';
import 'package:my_agency/module/customer/model/customer.dart';
import 'package:my_agency/module/logistic/model/logistic.dart';
import 'package:my_agency/module/supplier/model/supplier.dart';
import 'package:my_agency/module/transaction/model/transaction.dart';
import 'package:my_agency/module/transaction/model/transaction_info.dart';

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

  Future<List<Supplier>> findSupplier(int supplierId) async {
    final List<Map<String, dynamic>> maps = await supabase
        .from(SupabaseTables.suppliers)
        .select()
        .eq('supplier_id', supplierId);
    return List.generate(maps.length, (index) => Supplier.fromMap(maps[index]));
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

  // Transactions
  Future<List<TransactionInfo>> getTransactions(int transactionId) async {
    final List<Map<String, dynamic>> maps = await supabase
        .rpc('get_transaction_info', params: {'t_id': transactionId});
    return List.generate(
        maps.length, (index) => TransactionInfo.fromMap(maps[index]));
  }

  Future<List<TransactionInfo>> getAllTransactions() async {
    final List<Map<String, dynamic>> maps =
        await supabase.rpc('get_all_transaction_info');
    return List.generate(
        maps.length, (index) => TransactionInfo.fromMap(maps[index]));
  }

  Future<Transaction> createTransaction(Transaction transaction) async {
    final List<Map<String, dynamic>> maps =
        await supabase.rpc('add_transaction', params: {
      'p_customer_id': transaction.customerId,
      'p_supplier_id': transaction.supplierId,
      'p_bill_number': transaction.billNumber,
      'p_order_date':
          Utils.dateTimeToString(transaction.orderDate, 'yyyy-MM-dd'),
      'p_bill_amount': transaction.billAmount,
      'p_discount_amount': transaction.discountAmount,
      'p_tax_amount': transaction.taxAmount,
      'p_payment_status': transaction.paymentStatus,
      'p_product_qty': transaction.productQty
    });
    final list =
        List.generate(maps.length, (index) => Transaction.fromMap(maps[index]));
    return list.first;
  }

  Future<Transaction> updateTransaction(Transaction transaction) async {
    final List<Map<String, dynamic>> maps =
        await supabase.rpc('update_transaction', params: {
      'p_transaction_id': transaction.tranctionId,
      'p_customer_id': transaction.customerId,
      'p_supplier_id': transaction.supplierId,
      'p_bill_number': transaction.billNumber,
      'p_order_date':
          Utils.dateTimeToString(transaction.orderDate, 'yyyy-MM-dd'),
      'p_bill_amount': transaction.billAmount,
      'p_discount_amount': transaction.discountAmount,
      'p_tax_amount': transaction.taxAmount,
      'p_payment_status': transaction.paymentStatus,
      'p_product_qty': transaction.productQty
    });
    final list =
        List.generate(maps.length, (index) => Transaction.fromMap(maps[index]));
    return list.first;
  }

  Future<Logistics> createLogistics(Logistics logistics) async {
    final List<Map<String, dynamic>> maps =
        await supabase.rpc('add_logistics', params: {
      'p_transaction_id': logistics.tranctionId,
      'p_transport_name': logistics.transportName,
      'p_lr_number': logistics.lrNumber,
      'p_lr_date': Utils.dateTimeToString(logistics.lrDate, 'yyyy-MM-dd'),
      'p_number_of_bundles': logistics.bundleQty,
    });

    final list =
        List.generate(maps.length, (index) => Logistics.fromMap(maps[index]));
    return list.first;
  }

  Future<Logistics> updateLogistics(Logistics logistics) async {
    final List<Map<String, dynamic>> maps =
        await supabase.rpc('update_logistics', params: {
      'p_transaction_id': logistics.tranctionId,
      'p_transport_name': logistics.transportName,
      'p_lr_number': logistics.lrNumber,
      'p_lr_date': Utils.dateTimeToString(logistics.lrDate, 'yyyy-MM-dd'),
      'p_number_of_bundles': logistics.bundleQty,
    });

    final list =
        List.generate(maps.length, (index) => Logistics.fromMap(maps[index]));
    return list.first;
  }

  void getTransaction() async {
    // final List<Map<String, dynamic>> maps = await supabase
    //     .from(SupabaseTables.transactions)
    //     .select('*, customers(*), suppliers(*)');

    final List<Map<String, dynamic>> maps = await supabase
        .from(SupabaseTables.logistics)
        .select('*, transactions(*, suppliers(*), customers(*))');

    //await supabase.from(SupabaseTables.transactions)
    // .select('*', );
    //.eq('transactions.supplier_id', 2);

    print(maps);
  }
}
