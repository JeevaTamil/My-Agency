import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'supplier_report_state.dart';

class SupplierReportCubit extends Cubit<SupplierReportState> {
  SupplierReportCubit() : super(SupplierReportInitial());
}
