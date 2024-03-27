import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward_with_details.dart';

part 'bill_inward_state.dart';

class BillInwardCubit extends Cubit<BillInwardState> {
  BillInwardCubit()
      : super(BillInwardInitial(DatabaseHelper().getBillInwardsWithDetails()));

  void createBillInward(BillInward billInward) async {
    await DatabaseHelper().createBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwardsWithDetails()));
  }

  void updateBillInward(BillInward billInward) async {
    await DatabaseHelper().updateBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwardsWithDetails()));
  }

  void deleteBillInward(BillInward billInward) async {
    await DatabaseHelper().deleteBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwardsWithDetails()));
  }

  Future<void> fetchBillInwards() async {
    emit(BillInwardUpdated(DatabaseHelper().getBillInwardsWithDetails()));
  }
}
