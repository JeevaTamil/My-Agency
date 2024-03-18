import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_agency/helper/database/database_helper.dart';
import 'package:my_agency/module/bill_inward/model/bill_inward.dart';

part 'bill_inward_state.dart';

class BillInwardCubit extends Cubit<BillInwardState> {
  BillInwardCubit()
      : super(BillInwardInitial(DatabaseHelper().getBillInwards()));

  void createBillInward(BillInward billInward) async {
    await DatabaseHelper().createBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwards()));
  }

  void updateBillInward(BillInward billInward) async {
    await DatabaseHelper().updateBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwards()));
  }

  void deleteBillInward(BillInward billInward) async {
    await DatabaseHelper().deleteBillInward(billInward);
    emit(BillInwardUpdated(DatabaseHelper().getBillInwards()));
  }

  Future<void> fetchBillInwards() async {
    emit(BillInwardUpdated(DatabaseHelper().getBillInwards()));
  }
}
