part of 'bill_inward_cubit.dart';

@immutable
sealed class BillInwardState {
  final Future<List<BillInward>> billInwards;

  const BillInwardState(this.billInwards);
}

class BillInwardInitial extends BillInwardState {
  const BillInwardInitial(super.billInwards);
}

class BillInwardUpdated extends BillInwardState {
  const BillInwardUpdated(super.billInwards);
}
