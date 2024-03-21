import 'package:flutter/material.dart';
import 'package:dropdown_model_list/dropdown_model_list.dart';
import 'package:my_agency/helper/views/form_search_bar.dart';
import 'package:my_agency/module/supplier/cubit/supplier_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SupplierSearchDropDown extends StatefulWidget {
  SupplierSearchDropDown({super.key, required this.optionItemSelected});
  OptionItem optionItemSelected;

  @override
  State<SupplierSearchDropDown> createState() => _SupplierSearchDropDownState();
}

class _SupplierSearchDropDownState extends State<SupplierSearchDropDown> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: BlocBuilder<SupplierCubit, SupplierState>(
        builder: (context, state) {
          return FutureBuilder(
              future: state.suppliers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FormSearchBar(
                    searchableList: snapshot.data!,
                    hintText: 'Select Supplier',
                  );
                } else {
                  return const Text("No Data found");
                }
              });
        },
      ),
    );
  }
}
