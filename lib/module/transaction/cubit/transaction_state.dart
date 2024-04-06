part of 'transaction_cubit.dart';

@immutable
sealed class TransactionState {
  final Future<List<TransactionInfo>> transactions;

  const TransactionState(this.transactions);
}

final class TransactionInitial extends TransactionState {
  const TransactionInitial(super.transactions);
}

final class TransactionUpdated extends TransactionState {
  const TransactionUpdated(super.transactions);
}

final class TransactionSearch extends TransactionState {
  const TransactionSearch(super.transactions);
}
