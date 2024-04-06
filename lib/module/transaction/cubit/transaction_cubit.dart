import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/supabase/supabase_helper.dart';
import 'package:my_agency/module/logistic/model/logistic.dart';
import 'package:my_agency/module/transaction/model/transaction.dart';
import 'package:my_agency/module/transaction/model/transaction_info.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit()
      : super(TransactionInitial(SupabaseHelper().getAllTransactions()));

  Future<Transaction> createTransaction(Transaction transaction) {
    Future<Transaction> createdTransaction =
        SupabaseHelper().createTransaction(transaction);
    emit(TransactionUpdated(SupabaseHelper().getAllTransactions()));
    return createdTransaction;
  }

  Future<Transaction> updateTransaction(Transaction transaction) {
    Future<Transaction> createdTransaction =
        SupabaseHelper().updateTransaction(transaction);
    emit(TransactionUpdated(SupabaseHelper().getAllTransactions()));
    return createdTransaction;
  }

  Future<Logistics> createLogistics(Logistics logistics) {
    Future<Logistics> createdLogistics =
        SupabaseHelper().createLogistics(logistics);
    emit(TransactionUpdated(SupabaseHelper().getAllTransactions()));
    return createdLogistics;
  }

  Future<Logistics> updateLogistics(Logistics logistics) {
    Future<Logistics> updatedLogistics =
        SupabaseHelper().updateLogistics(logistics);
    emit(TransactionUpdated(SupabaseHelper().getAllTransactions()));
    return updatedLogistics;
  }
}
